import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms/constants.dart';
import 'package:lms/services/validation.dart';
import 'package:lms/views/home.dart';
import 'package:lms/widgets/choiceButtons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/services/auth.dart';
import 'package:lms/views/register.dart';
import 'package:lms/widgets/inputTextFields.dart';
import 'package:lms/widgets/submitBtn.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String id = 'loginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BodyLoginPage(),
      ),
    );
  }
}

class BodyLoginPage extends StatefulWidget {
  @override
  _BodyLoginPageState createState() => _BodyLoginPageState();
}

class _BodyLoginPageState extends State<BodyLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      dismissible: false,
      inAsyncCall: _isLoading,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/images/background.jpg').image,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  fit: BoxFit.cover),
            ),
            child: Form(
              key: _signInFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: kPageTitleTextStyle,
                  ),
                  Spacer(flex: 1),
                  Text(
                    'Access account',
                    style: kPageSubtitleTextStyle,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceButtons(
                          iconData: FontAwesomeIcons.github, onTap: () {}),
                      Spacer(),
                      ChoiceButtons(
                        onTap: () async {
                          final auth =
                              Provider.of<Auth>(context, listen: false);
                          setState(() {
                            _isLoading = true;
                          });
                          var result = await auth.signInGoogle(context);
                          setState(() {
                            _isLoading = false;
                          });
                          if (result)
                            Navigator.popAndPushNamed(context, HomePage.id);
                        },
                        iconData: FontAwesomeIcons.google,
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    'or Login with Email',
                    style: kPageSecondaryTextStyle,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: kPageHeading3TextStyle,
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  InputTextField(
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    textEditingController: emailController,
                    isPasswordField: false,
                    color: Colors.white,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password', style: kPageHeading3TextStyle)),
                  Spacer(
                    flex: 1,
                  ),
                  InputTextField(
                    validator: (value) => Validator.validatePassword(
                      password: value,
                    ),
                    textEditingController: passwordController,
                    color: Color(0xffF2F7FC),
                    isPasswordField: true,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  SubmitButton(
                    onTap: () async {
                      if (_signInFormKey.currentState!.validate()) {
                        final auth = Provider.of<Auth>(context, listen: false);
                        setState(() {
                          _isLoading = true;
                        });
                        var result = await auth.signIn(
                            context: context,
                            email: emailController.text.toString().trim(),
                            password: emailController.text.toString().trim());
                        setState(() {
                          _isLoading = false;
                        });
                        if (result)
                          Navigator.popAndPushNamed(context, HomePage.id);
                        else {
                          passwordController.clear();
                        }
                      }
                    },
                    text: 'Sign In',
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, RegisterPage.id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: kPageSecondaryTextStyle,
                        ),
                        Text(
                          " Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[600],
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
