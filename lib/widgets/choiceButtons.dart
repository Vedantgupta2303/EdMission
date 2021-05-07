import 'package:flutter/material.dart';

class ChoiceButtons extends StatelessWidget {
  Function onTap;
  IconData iconData;
  ChoiceButtons({required this.iconData, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: (MediaQuery.of(context).size.width - 20) * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                Colors.white70,
                Color(0xffF6F9FC),
                Color(0xffF6F9FC),
                Color(0xffF0F5FA),
                Colors.blueGrey.shade100.withAlpha(10)
              ])),
      child: TextButton.icon(
          onPressed: () => onTap(),
          icon: Icon(
            iconData,
            color: Color(0xffAEBED9),
          ),
          label: Text('')),
    );
  }
}
