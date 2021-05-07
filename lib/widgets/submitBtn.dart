import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'clayContainerHighlight.dart';

class SubmitButton extends StatefulWidget {
  double height;
  RichText? richText;
  String subtitle;
  String text;
  bool isActionEnabled;
  bool isNumberEnabled;
  int number;
  Function() onTap;
  Color? pColor;
  Color? sColor;

  SubmitButton(
      {required this.text,
      this.height = 60,
      this.subtitle = '',
      this.richText,
      this.isActionEnabled = false,
      this.number = 0,
      this.isNumberEnabled = false,
      required this.onTap,
      this.pColor,
      this.sColor});

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      curveType: CurveType.convex,
      parentColor: widget.sColor ?? Color(0xffF6FAFE),
      color: widget.pColor ?? Color(0xff2F4858),
      height: widget.subtitle != '' ? 80 : widget.height,
      borderRadius: 15,
      width: double.infinity,
      child: widget.isActionEnabled
          ? Padding(
              padding: widget.subtitle == ''
                  ? EdgeInsets.symmetric(horizontal: 20.0)
                  : EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.richText == null
                          ? Text(
                              widget.text,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            )
                          : Container(
                              padding: EdgeInsets.only(right: 40),
                              child: widget.richText!,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(),
                            ),
                      widget.subtitle != ''
                          ? SizedBox(
                              height: 5,
                            )
                          : Container(),
                      widget.subtitle != ''
                          ? Padding(
                              padding: EdgeInsets.only(right: 35.0),
                              child: Text(widget.subtitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.abel(
                                      fontSize: 14,
                                      color: Colors.blueGrey.shade700)),
                            )
                          : Container()
                    ],
                  ),
                  // Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: widget.isNumberEnabled
                        ? ClayContainer(
                            spread: 0,
                            color: Colors.pinkAccent.shade100,
                            parentColor: Colors.white,
                            depth: 2,
                            width: 40,
                            height: 40,
                            borderRadius: 15,
                            child: Center(
                              child: Text(
                                widget.number.toString(),
                                style: kHeading4.copyWith(color: Colors.white),
                              ),
                            ))
                        : ClayContainerHighlight(
                            iconData: CupertinoIcons.chevron_forward),
                  )
                ],
              ),
            )
          : TextButton(
              onPressed: widget.onTap,
              child: Text(
                widget.text,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ),
    );
  }
}
