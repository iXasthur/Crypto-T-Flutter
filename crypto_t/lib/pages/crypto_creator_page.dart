import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_t/apis/session.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/models/crypto_event.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:crypto_t/utils/widget/my_button.dart';
import 'package:crypto_t/utils/widget/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'app_routes.dart';

class CryptoCreator extends StatefulWidget {
  final CryptoAsset? asset;

  const CryptoCreator({Key? key, this.asset}) : super(key: key);

  @override
  _CryptoCreatorState createState() => _CryptoCreatorState();
}

class _CryptoCreatorState extends State<CryptoCreator> {
  VideoPlayerController? _videoController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eventNoteController = TextEditingController();

  final _mediaPicker = ImagePicker();

  Uri? _imageUri;
  Uri? _videoUri;
  LatLng? _eventPosition;

  @override
  void initState() {
    super.initState();

    if (widget.asset != null) {
      _nameController.text = widget.asset!.name;
      _codeController.text = widget.asset!.code;
      _descriptionController.text = widget.asset!.description;

      var imageDownloadURL = widget.asset!.iconFileData?.downloadURL;
      if (imageDownloadURL != null) {
        _imageUri = Uri.parse(imageDownloadURL);
      }

      var videoDownloadURL = widget.asset!.videoFileData?.downloadURL;
      if (videoDownloadURL != null) {
        _videoUri = Uri.parse(videoDownloadURL);
        _videoController = VideoPlayerController.network(videoDownloadURL)
          ..setLooping(true)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
      }

      var event = widget.asset!.suggestedEvent;
      if (event != null) {
        _eventNoteController.text = event.note;
        _eventPosition = LatLng(
          double.parse(event.latitude),
          double.parse(event.longitude),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    _videoController?.dispose();
    _eventNoteController.dispose();
    super.dispose();
  }

  Widget _deleteButton() => IconButton(
        onPressed: () {
          context.loaderOverlay.show();
          Session.shared.deleteRemoteAsset(widget.asset!, (error) {
            context.loaderOverlay.hide();
            if (error == null) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              print(error);
            }
          });
        },
        icon: Icon(CupertinoIcons.xmark),
        splashColor: Colors.transparent,
      );

  Widget _saveButton() => IconButton(
        onPressed: () {
          var name = _nameController.text.trim();
          var code = _codeController.text.trim();
          var description = _descriptionController.text.trim();
          if (name.length > 2 && code.length > 2) {
            CryptoEvent? event;

            if (_eventPosition != null) {
              event = CryptoEvent(
                _eventNoteController.text.trim(),
                _eventPosition!.latitude.toStringAsFixed(6),
                _eventPosition!.longitude.toStringAsFixed(6),
              );
            } else {
              event = null;
            }

            var newAsset = CryptoAsset(
              widget.asset?.id ?? Uuid().v4(),
              name,
              code,
              description,
              widget.asset?.iconFileData,
              widget.asset?.videoFileData,
              event,
            );

            context.loaderOverlay.show();
            Session.shared.updateRemoteAsset(newAsset, _imageUri, _videoUri,
                (error) {
                  context.loaderOverlay.hide();
              if (error == null) {
                Navigator.pop(context);
              } else {
                print(error);
              }
            });
          } else {
            print('Input is invalid');
          }
        },
        icon: Icon(CupertinoIcons.checkmark_alt),
        splashColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.createWithAutoBack(
        context,
        title: widget.asset == null ? "New Crypto" : "Edit Crypto",
        onBack: () {},
        actions: widget.asset != null
            ? [_deleteButton(), _saveButton()]
            : [_saveButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppStylesPrimary.safeAreaX,
            AppStylesPrimary.safeAreaYTop,
            AppStylesPrimary.safeAreaX,
            0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 10),
              MyTextField.create(
                context,
                _nameController,
                hint: 'Name',
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 10),
              MyTextField.create(
                context,
                _codeController,
                hint: 'Code',
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 10),
              MyTextField.create(
                context,
                _descriptionController,
                hint: 'Description',
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Icon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              _imageUri != null
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            // child: Image.network(imageUrl),
                            child: CachedNetworkImage(
                              imageUrl: _imageUri!.toString(),
                              placeholder: (context, url) =>
                                  SpinKitDoubleBounce(
                                color: Colors.amber,
                              ),
                              errorWidget: (context, url, error) => Image(
                                image: FileImage(File.fromUri(_imageUri!)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 10),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Select Icon',
                    onTap: () async {
                      final pickedFile = await _mediaPicker.getImage(
                          source: ImageSource.gallery);
                      setState(() {
                        if (pickedFile != null) {
                          _imageUri = File(pickedFile.path).uri;
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Delete Icon',
                    onTap: () {
                      setState(() {
                        _imageUri = null;
                      });
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Video",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              _videoUri != null
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Center(
                                child: _videoController?.value.isInitialized ??
                                        false
                                    ? AspectRatio(
                                        aspectRatio: 16.0 / 9.0,
                                        child: VideoPlayer(_videoController!),
                                      )
                                    : SpinKitDoubleBounce(color: Colors.purple),
                              ),
                            ),
                            _videoController?.value.isInitialized ?? false
                                ? IconButton(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    onPressed: () {
                                      var isPlaying =
                                          _videoController?.value.isPlaying;
                                      if (isPlaying != null) {
                                        setState(() {
                                          _videoController!.value.isPlaying
                                              ? _videoController!.pause()
                                              : _videoController!.play();
                                        });
                                      }
                                    },
                                    icon: Icon(
                                        _videoController?.value.isPlaying ??
                                                false
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 10),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Select Video',
                    onTap: () async {
                      final pickedFile = await _mediaPicker.getVideo(
                          source: ImageSource.gallery);
                      setState(() {
                        if (pickedFile != null) {
                          _videoUri = File(pickedFile.path).uri;

                          var oldVideoController = _videoController;
                          _videoController =
                              VideoPlayerController.file(File(pickedFile.path))
                                ..setLooping(true)
                                ..initialize().then((_) {
                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                  setState(() {
                                    oldVideoController?.dispose();
                                  });
                                });
                        } else {
                          print('No video selected.');
                        }
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Delete Video',
                    onTap: () {
                      setState(() {
                        _videoUri = null;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Event",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              _eventPosition != null
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Latitude',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              _eventPosition!.latitude.toStringAsFixed(6),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Longitude',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              _eventPosition!.longitude.toStringAsFixed(6),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        MyTextField.create(
                          context,
                          _eventNoteController,
                          hint: 'Note',
                          onChanged: (s) {
                            setState(() {});
                          },
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 10),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Pick Location',
                    onTap: () async {
                      var result = await Navigator.pushNamed(
                          context, AppRoutes.location_picker);
                      if (result is LatLng?) {
                        setState(() {
                          _eventPosition = result;
                        });
                      }
                    },
                  ),
                  SizedBox(width: 10),
                  MyButton.create(
                    context,
                    title: 'Delete Event',
                    onTap: () {
                      setState(() {
                        _eventNoteController.text = '';
                        _eventPosition = null;
                      });
                    },
                  )
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
