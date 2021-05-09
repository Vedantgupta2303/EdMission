import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../services/validation.dart';
import '../themes.dart';
import '../widgets/inputTextFields.dart';
import '../widgets/submitBtn.dart';
import 'home.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'registerPage';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: kStatusBarColor,
        statusBarIconBrightness: kStatusBarIconBrightness));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BodyRegisterPage(),
      ),
    );
  }
}

class BodyRegisterPage extends StatefulWidget {
  @override
  _BodyRegisterPageState createState() => _BodyRegisterPageState();
}

class _BodyRegisterPageState extends State<BodyRegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();

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
              image: kBackgroundImage,
            ),
            child: Form(
              key: _registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(fontSize: 25)),
                  ),
                  Spacer(flex: 1),
                  Text(
                    'Create account',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey[400]),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
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
                      child: Text(
                        'Password',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      )),
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
                      if (_registerFormKey.currentState!.validate()) {
                        final auth = Provider.of<Auth>(context, listen: false);
                        setState(() {
                          _isLoading = true;
                        });
                        var result = await auth.register(
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
                    text: 'Register',
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, LoginPage.id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.blueGrey[400],
                                  fontWeight: FontWeight.w400)),
                        ),
                        Text(
                          " Login",
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
