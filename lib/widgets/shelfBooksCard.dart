import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/constants.dart';
import 'package:lms/models/books.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ShelfBooksCard extends StatelessWidget {
  FirebaseBooks firebaseBooks;
  ShelfBooksCard({required this.firebaseBooks});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 80,
            margin: EdgeInsets.only(right: 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              firebaseBooks.imageLinks[0],
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  firebaseBooks.categories.join(", "),
                  overflow: TextOverflow.ellipsis,
                  style: kPageSubtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  firebaseBooks.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kPageHeading3TextStyle,
                ),
                Text(
                  firebaseBooks.authors.join(","),
                  overflow: TextOverflow.ellipsis,
                  style: kPageSecondaryTextStyle,
                ),
                Icon(CupertinoIcons.heart)
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  center: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      Spacer(),
                      Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.orange,
                      ),
                      Icon(
                        CupertinoIcons.arrow_right,
                        size: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  progressColor: Colors.blueGrey,
                  percent: firebaseBooks.availability / 10,
                  radius: 65,
                ),
                Text(firebaseBooks.availability.toString() + '/10')
              ],
            ),
          )
        ],
      ),
    );
  }
}
