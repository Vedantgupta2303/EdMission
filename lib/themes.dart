import 'package:flutter/material.dart';

final kStatusBarColor = Colors.blue[50];
final kStatusBarIconBrightness = Brightness.dark;

final kBackgroundImage = DecorationImage(
    image: Image.asset('assets/images/background.jpg').image,
    colorFilter:
        new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
    fit: BoxFit.cover);
