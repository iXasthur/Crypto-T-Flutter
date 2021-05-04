import 'package:crypto_t/apis/session.dart';
import 'package:crypto_t/pages/app_routes.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:crypto_t/utils/widget/my_button.dart';
import 'package:crypto_t/utils/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthScaffold extends StatefulWidget {
  AuthScaffold({Key? key}) : super(key: key);

  @override
  _AuthScaffoldState createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.text = "api@example.com";
    _passwordController.text = "123456";

    // Future(() {
    //   var email = _emailController.text.trim();
    //   var password = _passwordController.text.trim();
    //   Session.shared.signInEmail(email, password, (error) {
    //     if (error == null) {
    //       Navigator.pushReplacementNamed(context, AppRoutes.home);
    //     } else {
    //       print(error);
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateInput() {
    if (_emailController.text.length > 2 && _passwordController.text.length > 5) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.create(
        context,
        title: "Authorization".tr(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              AppStylesPrimary.safeAreaX,
              0,
              AppStylesPrimary.safeAreaX,
              25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome!'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 15),
              MyTextField.create(
                context,
                _emailController,
                hint: 'Email'.tr(),
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              MyTextField.create(
                context,
                _passwordController,
                hint: 'Password'.tr(),
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Sign In'.tr(),
                    onTap: validateInput()
                        ? () {
                          var email = _emailController.text.trim();
                          var password = _passwordController.text.trim();
                          context.loaderOverlay.show();
                          Session.shared.signInEmail(email, password, (error) {
                            context.loaderOverlay.hide();
                            if (error == null) {
                              Navigator.pushReplacementNamed(context, AppRoutes.home);
                            } else {
                              print(error);
                            }
                          }
                          );
                        }
                        : null,
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Sign Up'.tr(),
                    onTap: validateInput()
                        ? () {
                          var email = _emailController.text.trim();
                          var password = _passwordController.text.trim();
                          context.loaderOverlay.show();
                          Session.shared.signUpEmail(email, password, (error) {
                            if (error == null) {
                              context.loaderOverlay.hide();
                              Navigator.pushReplacementNamed(context, AppRoutes.home);
                            } else {
                              print(error);
                            }
                          });
                        }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
