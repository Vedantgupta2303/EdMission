import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

final kHeading1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, textStyle: TextStyle(fontSize: 25));

final kHeading2 = TextStyle(
    fontWeight: FontWeight.w600, fontSize: 18, color: Colors.grey[400]);

final kHeading4 = GoogleFonts.montserrat(
    textStyle:
        TextStyle(color: Colors.blueGrey[400], fontWeight: FontWeight.w400));

final kHeading3 = GoogleFonts.montserrat(
    textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16));

void kShowSnackBar(BuildContext context, String content, bool noError) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: noError ? Colors.green : Colors.redAccent,
    content: Text(
      content,
      style: TextStyle(color: Colors.white, letterSpacing: 0.5),
    ),
  ));
}

final kShowToast = Fluttertoast.showToast(
    msg: "Error connecting to the internet",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

final String kDpParentUrl = 'gs://edmissions-211e5.appspot.com//dp/';
