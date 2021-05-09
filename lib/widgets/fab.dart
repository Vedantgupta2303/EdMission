import 'dart:io';
import 'dart:typed_data';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import 'clayContainerHighlight.dart';

class ActionFab extends StatefulWidget {
  @override
  _ActionFabState createState() => _ActionFabState();
}

class _ActionFabState extends State<ActionFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  final ImagePicker picker = ImagePicker();

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  void showSnackBar(BuildContext context, String content, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.green : Colors.redAccent,
      content: Text(
        content,
        style: kHeading4.copyWith(color: Colors.white, letterSpacing: 0.5),
      ),
    ));
  }

  Widget qrCodeScanner() {
    return Container(
      child: ClayContainerHighlight(
          onTap: () async {}, iconData: CupertinoIcons.printer),
    );
  }

  Widget barCodeScanner() {
    return Container(
      child: ClayContainerHighlight(
        onTap: () {
          print('bar');
        },
        iconData: CupertinoIcons.share,
      ),
    );
  }

  Widget imageScanner() {
    return Container(
      child: ClayContainerHighlight(
        onTap: () {},
        iconData: Icons.search,
      ),
    );
  }

  Widget toggle() {
    return Container(
      height: 80,
      width: 80,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 10,
          shape: PolygonBorder(
            // side: BorderSide(
            //     color: Colors.white,
            //     // width: ((_animateIcon.value * 10) % 5) + 2),
            sides: 6,
            borderRadius: 10.0, // Default 0.0 degrees
            rotate: _animateIcon.value * 90, // Default 0.0 degrees
          ),
          // backgroundColor: Color(0xff2F4858),
          clipBehavior: Clip.hardEdge,
          onPressed: animate,
          tooltip: 'Toggle',
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff2F4858),
              Color(0xffF6FAFE),
            ], stops: [
              0.7,
              0.9
            ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: Center(
              child: AnimatedIcon(
                size: 16 - ((_animateIcon.value * 5)),
                icon: AnimatedIcons.menu_close,
                progress: _animateIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  0.0, (1 - _translateButton.value) * 70, 0),
              child: ClayContainer(
                depth: 5,
                borderRadius: 15,
                color: Color(0xffF2F7FC),
                // decoration: BoxDecoration(
                //     color: Color(0xff6683AB),
                //     // gradient: LinearGradient(
                //     //     end: Alignment.bottomRight,
                //     //     begin: Alignment.topLeft,
                //     //     colors: [
                //     //       Colors.white70,
                //     //       Color(0xffF6F9FC),
                //     //       Color(0xffF6F9FC),
                //     //       Color(0xffF0F5FA),
                //     //       Colors.blueGrey.shade100.withAlpha(10)
                //     //     ]),
                //     borderRadius: BorderRadius.all(Radius.circular(25))),
                height: 70,
                width: _translateButton.value * 250,
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                _translateButton.value * -80.0,
                (1 - _translateButton.value) * 70,
                0.0,
              ),
              child: imageScanner(),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                (1 - _translateButton.value) * 70,
                0.0,
              ),
              child: barCodeScanner(),
            ),
            Transform(
              transform: Matrix4.translationValues(
                _translateButton.value * 80.0,
                (1 - _translateButton.value) * 70,
                0.0,
              ),
              child: qrCodeScanner(),
            ),
          ],
        ),
        toggle(),
      ],
    );
  }
}
