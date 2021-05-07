import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants.dart';

class ShelfBooksCard extends StatelessWidget {
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
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '',
                  overflow: TextOverflow.ellipsis,
                  style: kHeading2.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kHeading3,
                ),
                Text(
                  '',
                  overflow: TextOverflow.ellipsis,
                  style: kHeading4,
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
                  radius: 65,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
