import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:crypto_t/utils/widget/my_button.dart';
import 'package:crypto_t/utils/widget/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptoCreator extends StatefulWidget {
  final CryptoAsset? asset;

  const CryptoCreator({Key? key, this.asset}) : super(key: key);

  @override
  _CryptoCreatorState createState() => _CryptoCreatorState();
}

class _CryptoCreatorState extends State<CryptoCreator> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Uri? _localImage;
  Uri? _localVideo;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.createWithAutoBack(
        context,
        title: "New Crypto",
        onBack: () {

        },
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(CupertinoIcons.checkmark_alt),
            splashColor: Colors.transparent,
          ),
        ],
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
              SizedBox(height: 10),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Select Icon',
                    onTap: () {

                    },
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Delete Icon',
                    onTap: () {

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
              SizedBox(height: 10),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Select Video',
                    onTap: () {

                    },
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Delete Video',
                    onTap: () {

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
              SizedBox(height: 10),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Pick Location',
                    onTap: () {

                    },
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Delete Event',
                    onTap: () {

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