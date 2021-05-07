import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class IssuedBookCard extends StatefulWidget {
  @override
  _IssuedBookCardState createState() => _IssuedBookCardState();
}

class _IssuedBookCardState extends State<IssuedBookCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(right: 20),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
          child: Image.network(
            "https://covers.openlibrary.org/b/id/8739161-L.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Text(
          'Fantastic Mr. Fox',
          style: kHeading3,
        ),
        Row(
          children: [
            Text('Chloe Hooper', style: kHeading4),
            Icon(
              CupertinoIcons.star,
              color: Colors.amber[600],
            )
          ],
        )
      ],
    );
  }
}
