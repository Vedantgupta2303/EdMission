import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../views/tabs/user.dart';
import 'submitBtn.dart';

class ImageUploader extends StatefulWidget {
  static String id = 'imageUpload';

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

enum AppState {
  free,
  picked,
}

String text = 'Upload';

class _ImageUploaderState extends State<ImageUploader> {
  late AppState state;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  void showSnackBar(BuildContext context, String content, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.green : Colors.redAccent,
      content: Text(
        content,
        style: TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 1000,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 40, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: Image.asset('assets/images/background.jpg').image,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Text(
                  'Pick an image',
                  style: kHeading1,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 200,
                    width: 200,
                    child: ClipOval(
                      clipBehavior: Clip.hardEdge,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey.shade200,
                        child: imageFile != null
                            ? Image.file(imageFile!,
                                height: 200, width: 200, fit: BoxFit.fill)
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 100,
                              ),
                      ),
                    )),
                SizedBox(height: 50),
                Text(
                  'Select an image source',
                  style: kHeading4,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImage(ImageSource.camera);
                        },
                        child: FrostedGlassUserInfo(
                          title: 'Camera',
                          subtitle: '',
                          iconData: CupertinoIcons.camera_fill,
                          showActionButton: true,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: FrostedGlassUserInfo(
                          color: Colors.pinkAccent,
                          title: 'Gallery',
                          subtitle: '',
                          iconData: CupertinoIcons.photo,
                          showActionButton: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SubmitButton(text: text, onTap: uploadImage)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      sleep(Duration(milliseconds: 500));
      _cropImage();
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        androidUiSettings: AndroidUiSettings(
            // hideBottomControls: true,
            toolbarTitle: 'Adjust picture',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Adjust picture',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<void> uploadImage() async {
    // bool result = false;
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    if (imageFile != null) {
      firebase_storage.UploadTask task = storage
          .ref()
          .child('dp')
          .child(FirebaseAuth.instance.currentUser!.email
                  .toString()
                  .split('@')[0] +
              '.jpg')
          .putFile(imageFile!);
      task.snapshotEvents.listen(
          (firebase_storage.TaskSnapshot snapshot) async {
        text = 'Uploading';
        var imgUrl = await snapshot.ref.getDownloadURL();
      }, onError: (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print(task.snapshot);

        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
      });
      try {
        await task;
        setState(() {
          text = 'Uploaded';
        });
        showSnackBar(context, 'Successfully updated!', true);
        // final String path = await getApplicationDocumentsDirectory().path;

// copy the file to a new path
        // final File newImage = await imageFile!.copy('$path/image1.png');
      } on firebase_core.FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
        showSnackBar(context, 'Error updating profile picture', false);
        // return false;
      }
    }

    Navigator.pop(context);
  }
}
