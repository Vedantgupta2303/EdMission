import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/constants.dart';
import 'package:lms/views/tabs/user.dart';
import 'package:lms/widgets/clayContainerHighlight.dart';
import 'package:lms/widgets/submitBtn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: kPageTitleTextStyle,
              ),
              ClayContainer(
                  color: Colors.amber.shade600,
                  parentColor: Color(0xffF2F7FC),
                  depth: 2,
                  width: 100,
                  height: 40,
                  borderRadius: 15,
                  child: Center(
                    child: Text(
                      "14 records",
                      style:
                          kPageHeading3TextStyle.copyWith(color: Colors.white),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Current Borrowings',
            style: kPageHeading3TextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          SubmitButton(
            isActionEnabled: true,
            height: 100,
            text: 'Due Date : 15-Apr-2021',
            onTap: () {},
            pColor: Colors.green.shade600.withAlpha(200),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.blueGrey,
            height: 2,
            thickness: 2,
          ),
          SizedBox(height: 20),
          Text(
            'Previous Transactions',
            style: kPageHeading3TextStyle,
          ),
          SizedBox(height: 20),
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FrostedGlassUserInfo(
                      iconData: CupertinoIcons.arrow_right,
                      showActionButton: true,
                      color: Colors.amber.shade400,
                      title: 'Issued : 27-Mar-2021',
                      subtitle: 'Returned : 5-Apr-2021'),
                );
              })
        ],
      ),
    );
  }
}
