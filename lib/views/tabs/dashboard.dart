import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../widgets/clayContainerHighlight.dart';
import '../../widgets/issuedBookCard.dart';
import '../../widgets/shelfBooksCard.dart';
import '../../widgets/submitBtn.dart';

class DashBoardTab extends StatefulWidget {
  @override
  _DashBoardTabState createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> {
  @override
  Widget build(BuildContext context) {
    // var listBooks =
    //     Provider.of<AllFirebaseBooks>(context, listen: false).firebaseBooksList;
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'List of all widgets!',
                  style: kHeading3,
                ),
                Spacer(),
                ClayContainerHighlight(
                  iconData: CupertinoIcons.bell,
                ),
                SizedBox(
                  width: 10,
                ),
                ClayContainerHighlight(
                    onTap: () {}, iconData: CupertinoIcons.search)
              ],
            ),
          ],
        ));
  }
}
