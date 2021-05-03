import 'package:crypto_t/apis/session.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:crypto_t/utils/widget/my_button.dart';
import 'package:crypto_t/utils/widget/my_text_field.dart';
import 'package:flutter/material.dart';

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
    _emailController.text = "api@example.com";
    _passwordController.text = "123456";
    super.initState();
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
        title: "Authorization",
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
                'Welcome!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 15),
              MyTextField.create(
                context,
                _emailController,
                hint: 'Email',
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              MyTextField.create(
                context,
                _passwordController,
                hint: 'Password',
                onChanged: (s) {
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  MyButton.create(
                    context,
                    title: 'Sign In',
                    onTap: validateInput()
                        ? () {
                          var email = _emailController.text.trim();
                          var password = _passwordController.text.trim();
                          Session.shared.signInEmail(email, password, (error) {
                            print(error);
                          });
                        }
                        : null,
                  ),
                  SizedBox(width: 15),
                  MyButton.create(
                    context,
                    title: 'Sign Up',
                    onTap: validateInput()
                        ? () {
                          var email = _emailController.text.trim();
                          var password = _passwordController.text.trim();
                          Session.shared.signUpEmail(email, password, (error) {
                            print(error);
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
