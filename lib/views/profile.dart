import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../services/auth.dart';
import '../services/validation.dart';
import '../widgets/clayContainerHighlight.dart';
import '../widgets/imageUpload.dart';
import '../widgets/inputTextFields.dart';
import '../widgets/submitBtn.dart';
import 'home.dart';

class ProfilePage extends StatefulWidget {
  static String id = 'profilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController rollController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    /**
     * Load user data and feed it into the profile page for editing purpose.
     */
    return Scaffold(
      body: ModalProgressHUD(
        dismissible: false,
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            height: 1000,
            padding: EdgeInsets.only(left: 20, top: 40, right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/images/background.jpg').image,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  fit: BoxFit.cover),
            ),
            child: Form(
              key: _registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Update Profile',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(fontSize: 25)),
                  ),
                  Spacer(flex: 2),
                  Container(
                    height: 150,
                    width: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.blueGrey.shade200,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 100,
                              ),
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: ClayContainerHighlight(
                              onTap: () {
                                print('here');
                                Navigator.pushNamed(context, ImageUploader.id);
                              },
                              iconData: CupertinoIcons.camera),
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  InputTextField(
                    validator: (value) => Validator.validateName(
                      name: value,
                    ),
                    textInputType: TextInputType.name,
                    textEditingController: nameController,
                    isPasswordField: false,
                    color: Colors.white,
                  ),
                  Spacer(
                    flex: 1,
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
                    isDisabled: true,
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    textEditingController: emailController,
                    isPasswordField: true,
                    color: Color(0xffF2F7FC),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Roll No.',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phone',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  InputTextField(
                    validator: (value) => Validator.validatePhone(
                      phone: value,
                    ),
                    textInputType: TextInputType.phone,
                    textEditingController: phoneController,
                    isPasswordField: false,
                    color: Colors.white,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Address',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  InputTextField(
                    validator: (value) => Validator.validateAddress(
                      address: value,
                    ),
                    textInputType: TextInputType.streetAddress,
                    textEditingController: addressController,
                    isPasswordField: false,
                    color: Colors.white,
                  ),
                  Spacer(
                    flex: 1,
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
                        /**
                         * TODO:
                         * Update User profile info and then write the corresponding data into firebase.
                         */
                        setState(() {
                          _isLoading = false;
                        });
                        var result = true;
                        if (result) {
                          kShowSnackBar(context, 'Updated Successfully', true);
                          setState(() {});
                          Navigator.popAndPushNamed(context, HomePage.id);
                        } else {
                          kShowSnackBar(context,
                              'An error occured, please retry!', false);
                        }
                      }
                    },
                    text: 'Update',
                  ),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
