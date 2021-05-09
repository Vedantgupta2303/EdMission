import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';
import '../../services/validation.dart';
import '../../themes.dart';
import '../../widgets/clayContainerHighlight.dart';
import '../../widgets/inputTextFields.dart';
import '../../widgets/submitBtn.dart';
import 'call.dart';

class IndexPage extends StatefulWidget {
  static String id = 'indexPage';
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _channelController.text = 'sts2021';
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: kBackgroundImage,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: ClayContainerHighlight(
                    iconData: CupertinoIcons.arrow_left,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: Image.asset(
                          'assets/images/sts-logo.jpg',
                          height: 120,
                          width: 120,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Channel ID',
                  style: kHeading3,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: InputTextField(
                      isPasswordField: false,
                      validator: (value) =>
                          Validator.validateName(name: _channelController.text),
                      color: Color(0xffF2F7FC),
                      textEditingController: _channelController,
                    ))
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(ClientRole.Broadcaster.toString()),
                      leading: Radio(
                        value: ClientRole.Broadcaster,
                        groupValue: _role,
                        onChanged: (ClientRole? value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(ClientRole.Audience.toString()),
                      leading: Radio(
                        value: ClientRole.Audience,
                        groupValue: _role,
                        onChanged: (ClientRole? value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SubmitButton(
                          onTap: onJoin,
                          text: 'Join Interview',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
