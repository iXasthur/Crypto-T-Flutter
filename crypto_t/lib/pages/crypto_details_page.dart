import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptoAsset asset;

  const CryptoDetailsPage({Key? key, required this.asset}) : super(key: key);

  @override
  _CryptoDetailsPageState createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
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
                                color: Colors.amber, size: 100),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.deepPurpleAccent,
                          height: 150,
                        ),
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
