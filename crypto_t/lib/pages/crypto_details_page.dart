import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_t/apis/session.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_routes.dart';

class CryptoDetailsPage extends StatefulWidget {
  final String assetId;

  const CryptoDetailsPage({Key? key, required this.assetId}) : super(key: key);

  @override
  _CryptoDetailsPageState createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {

  VideoPlayerController? _controller;
  String? _controllerUrl;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var asset = Session.shared.getLocalAsset(widget.assetId);

    if (asset == null) {
      return Scaffold(
        appBar: MyAppBar.createWithAutoBack(
            context, title: 'Invalid asset', onBack: () {}),
      );
    }

    var imageUrl = asset.iconFileData?.downloadURL;
    var videoUrl = asset.videoFileData?.downloadURL;
    var event = asset.suggestedEvent;

    if (videoUrl != _controllerUrl) {
      if (videoUrl == null) {
        _controller?.dispose();
        _controller = null;
      } else {
        var oldVideoController = _controller;
        _controller = VideoPlayerController.network(videoUrl)
          ..setLooping(true)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            
            // Delay to fix iOS player not appearing
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _controllerUrl = videoUrl;
                oldVideoController?.dispose();
              });
            });
          });
      }
    }

    return Scaffold(
      appBar: MyAppBar.createWithAutoBack(context,
          title: asset.name,
          onBack: () {},
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, AppRoutes.creator, arguments: asset);
                setState(() {});
              },
              icon: Icon(CupertinoIcons.pencil),
              splashColor: Colors.transparent,
            ),
          ]),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: imageUrl != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(90.0),
                      // child: Image.network(imageUrl),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            SpinKitDoubleBounce(
                              color: Colors.amber,
                            ),
                        errorWidget: (context, url, error) =>
                            Icon(CupertinoIcons.cube, size: 100),
                      ),
                    )
                        : Icon(CupertinoIcons.cube, size: 100),
                  ),
                  SizedBox(width: AppStylesPrimary.safeAreaX),
                  Text(
                    asset.code,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              asset.description.isNotEmpty
                  ? Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Description".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              asset.description,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : Container(),
              videoUrl != null
                  ? Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Video".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Center(
                          child: _controller?.value.isInitialized ?? false
                              ? AspectRatio(
                            aspectRatio: 16.0 / 9.0,
                            child: VideoPlayer(_controller!),
                          )
                              : SpinKitDoubleBounce(color: Colors.purple),
                        ),
                      ),
                      _controller?.value.isInitialized ?? false
                          ? IconButton(
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        onPressed: () {
                          var isPlaying =
                              _controller?.value.isPlaying;
                          if (isPlaying != null) {
                            setState(() {
                              _controller!.value.isPlaying
                                  ? _controller!.pause()
                                  : _controller!.play();
                            });
                          }
                        },
                        icon: Icon(
                            _controller?.value.isPlaying ?? false
                                ? Icons.pause
                                : Icons.play_arrow),
                      )
                          : Container(),
                    ],
                  ),
                ],
              )
                  : Container(),
              event != null
                  ? Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Event".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                        'Latitude'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        event.latitude,
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
                        'Longitude'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        event.longitude,
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
                    children: [
                      Text(
                        event.note,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              )
                  : Container(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
