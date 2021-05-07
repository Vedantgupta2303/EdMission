import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/constants.dart';
import 'package:lms/models/user.dart';
import 'package:lms/services/auth.dart';
import 'package:lms/services/validation.dart';
import 'package:lms/views/home.dart';
import 'package:lms/views/login.dart';
import 'package:lms/widgets/clayContainerHighlight.dart';
import 'package:lms/widgets/imageUpload.dart';
import 'package:lms/widgets/inputTextFields.dart';
import 'package:lms/widgets/submitBtn.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

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

  void showSnackBar(BuildContext context, String content, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      content: Text(
        content,
        style: TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    ));
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    emailController.text = FirebaseAuth.instance.currentUser!.email ?? '';
    var user = Provider.of<LMSUser>(context, listen: false);
    var imageTitle =
        FirebaseAuth.instance.currentUser!.email.toString().split('@')[0] +
            '.jpg';
    nameController.text = user.name;
    rollController.text = user.rollNo;
    phoneController.text = user.phone;
    addressController.text = user.address;
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
                          child: Provider.of<LMSUser>(context, listen: false)
                                      .imageFile ==
                                  null
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.blueGrey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                )
                              : Image.file(
                                  Provider.of<LMSUser>(context, listen: false)
                                      .imageFile!,
                                  fit: BoxFit.fill,
                                ),
                        ),
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
                  InputTextField(
                    validator: (value) => Validator.validateRoll(
                      roll: value,
                    ),
                    textInputType: TextInputType.text,
                    textEditingController: rollController,
                    isPasswordField: false,
                    color: Colors.white,
                  ),
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
                        var lmsUser =
                            Provider.of<LMSUser>(context, listen: false);
                        lmsUser.updateUser(
                            name: nameController.text,
                            phone: phoneController.text,
                            rollNo: rollController.text,
                            address: addressController.text);
                        var result =
                            await LMSUser.setUserToFirebase(context, lmsUser);
                        setState(() {
                          _isLoading = false;
                        });
                        if (result) {
                          showSnackBar(context, 'Updated Successfully', false);
                          setState(() {});
                          Navigator.popAndPushNamed(context, HomePage.id);
                        } else {
                          showSnackBar(
                              context, 'An error occured, please retry!', true);
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
