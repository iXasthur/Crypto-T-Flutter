import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptoAsset asset;

  const CryptoDetailsPage({Key? key, required this.asset}) : super(key: key);

  @override
  _CryptoDetailsPageState createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    var videoData = widget.asset.videoFileData;
    if (videoData != null) {
      _controller = VideoPlayerController.network(videoData.downloadURL)
        ..setLooping(true)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var imageUrl = widget.asset.iconFileData?.downloadURL;
    var videoUrl = widget.asset.videoFileData?.downloadURL;
    var event = widget.asset.suggestedEvent;

    return Scaffold(
      appBar: MyAppBar.createWithAutoBack(context,
          title: widget.asset.name,
          onBack: () {},
          actions: [
            IconButton(
              onPressed: () {
                // Go to creator
              },
              icon: Icon(CupertinoIcons.pencil),
              splashColor: Colors.transparent,
            ),
          ]),
      body: Padding(
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
                            placeholder: (context, url) => SpinKitDoubleBounce(
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
                  widget.asset.code,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            widget.asset.description.isNotEmpty
                ? Column(
                    children: [
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
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  widget.asset.description,
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
                            "Video",
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
                                  color: Theme.of(context).scaffoldBackgroundColor,
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
                            "Event",
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
                            'Latitude',
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
                            'Longitude',
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
          ],
        ),
      ),
    );
  }
}
