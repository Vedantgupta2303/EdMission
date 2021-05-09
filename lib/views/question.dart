import 'package:clay_containers/widgets/clay_container.dart';
import 'package:edmissions/models/tabs.dart';
import 'package:edmissions/views/details.dart';
import 'package:edmissions/views/home.dart';
import 'package:edmissions/widgets/clayContainerHighlight.dart';
import 'package:edmissions/widgets/submitBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_card_swipper/widgets/flutter_page_indicator/flutter_page_indicator.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class QuestionBook extends StatefulWidget {
  static String id = 'questionPage';
  @override
  _QuestionBookState createState() => _QuestionBookState();
}

class _QuestionBookState extends State<QuestionBook> {
  List<String> question = [
    'Admission Sought for Class*',
    'Name of the Pupil*',
    'Date of Birth*',
    'Nationality*',
    'Category*',
    'Gender*',
    'Residential Address*',
    'Pincode*',
    'Blood Group*',
    'Mother Tongue*',
    'Identification Marks*',
    'Previos School Name',
    'Previous Grade cumulative percentage',
    'Is the Child Specially-abled',
    'Language Preference*',
    "Family Background and Parent's Occupation",
    'Sibling Details',
    'Undertaking'
  ];

  final agree = ['I, agree', 'I am not sure'];
  var currentAgreement;

  final kTextFormFieldStyle = TextStyle(
      color: Color(0xff6683AB),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal);
  final kTextFormDecorationStyle =
      InputDecoration(border: OutlineInputBorder());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentAgreement = agree[0];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> formWidgets = [
      InformationTile(
          content: TextFormField(
              decoration: kTextFormDecorationStyle,
              keyboardType: TextInputType.number),
          title: question[0],
          isExpanded: true),
      TextFormField(
        maxLines: 5,
        style: kTextFormFieldStyle,
        cursorRadius: Radius.circular(4),
        cursorHeight: 20,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            hintText: 'Enter Name',
            labelStyle: TextStyle(color: Colors.amber.shade800, fontSize: 16),
            hintStyle: kHeading4,
            labelText: question[1]),
      ),
      Column(
        children: [
          InformationTile(
            content: TextFormField(decoration: kTextFormDecorationStyle),
            title: question[2],
            isExpanded: true,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[3],
            isExpanded: false,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[4],
            isExpanded: false,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[5],
            isExpanded: false,
          ),
        ],
      ),
      TextFormField(
        maxLines: 5,
        style: kTextFormFieldStyle,
        cursorRadius: Radius.circular(4),
        cursorHeight: 20,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            hintText: 'Please enter your complete residential address',
            labelStyle: TextStyle(color: Colors.amber.shade800, fontSize: 16),
            hintStyle: kHeading4,
            labelText: question[6]),
      ),
      Column(
        children: [
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[7],
            isExpanded: true,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[8],
            isExpanded: false,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[9],
            isExpanded: false,
          ),
        ],
      ),
      TextFormField(
        maxLines: 5,
        style: kTextFormFieldStyle,
        cursorRadius: Radius.circular(4),
        cursorHeight: 20,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            hintText: 'Enter your identification marks(if any)',
            labelStyle: TextStyle(color: Colors.amber.shade800, fontSize: 16),
            hintStyle: kHeading4,
            labelText: question[10]),
      ),
      TextFormField(
        maxLines: 5,
        style: kTextFormFieldStyle,
        cursorRadius: Radius.circular(4),
        cursorHeight: 20,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            hintText: 'Enter your previous school details(if any)',
            labelStyle: TextStyle(color: Colors.amber.shade800, fontSize: 16),
            hintStyle: kHeading4,
            labelText: question[11]),
      ),
      Column(
        children: [
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[12],
            isExpanded: true,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[13],
            isExpanded: false,
          ),
          InformationTile(
            content: TextFormField(
              decoration: kTextFormDecorationStyle,
            ),
            title: question[14],
            isExpanded: false,
          ),
        ],
      ),
      TextFormField(
        maxLines: 5,
        style: kTextFormFieldStyle,
        cursorRadius: Radius.circular(4),
        cursorHeight: 20,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            hintText:
                'Enter your family backgroud and Parent\'s occupation details',
            labelStyle: TextStyle(color: Colors.amber.shade800, fontSize: 16),
            hintStyle: kHeading4,
            labelText: question[15]),
      ),
      Column(children: [
        InformationTile(
          content: TextFormField(
            decoration: kTextFormDecorationStyle,
          ),
          title: question[16],
          isExpanded: true,
        ),
      ]),
      Column(
        children: [
          InformationTile(
            content: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: agree.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    dense: true,
                    activeColor: Colors.green,
                    title: Text(
                      agree[index].toString(),
                      style: kHeading4,
                    ),
                    value: agree[index],
                    groupValue: currentAgreement,
                    onChanged: (value) {
                      setState(() {
                        currentAgreement = value;
                      });
                    },
                  );
                }),
            title: question[17],
            isExpanded: true,
          ),
          SizedBox(
            height: 20,
          ),
          ClayContainer(
              color: Colors.green,
              parentColor: Color(0xffF2F7FC),
              depth: 2,
              width: double.infinity,
              height: 40,
              borderRadius: 15,
              child: Center(
                child: Text(
                  "Submit",
                  style: kHeading3.copyWith(color: Colors.white),
                ),
              ))
        ],
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.yellow,
                Colors.red,
                Colors.indigo,
                Colors.teal,
              ],
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Swiper(
                  loop: false,
                  indicatorLayout: PageIndicatorLayout.COLOR,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey.shade50, blurRadius: 10)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Question ${index + 1}/${formWidgets.length}',
                                  style: kHeading3.copyWith(
                                    color: Colors.pink,
                                    fontSize: 20,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    kShowSnackBar(
                                        context,
                                        'Swipe Right to contine to next question',
                                        true);
                                  },
                                  child: Icon(
                                    Icons.swipe,
                                    size: 28,
                                    color: Colors.amber,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            formWidgets[index]
                          ],
                        ),
                      ),
                      width: 300,
                      height: 400,
                    );
                  },
                  itemCount: formWidgets.length,
                  itemWidth: 350.0,
                  itemHeight: 400,
                  layout: SwiperLayout.TINDER,
                  pagination:
                      new SwiperPagination(margin: new EdgeInsets.all(5.0)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 34,
                      width: 34,
                      margin: EdgeInsets.only(right: 10),
                      child: ClayContainerHighlight(
                        iconData: CupertinoIcons.arrow_left,
                        onTap: () {
                          print('tapped');
                          Navigator.popAndPushNamed(context, HomePage.id);
                        },
                      ),
                    ),
                    Text(
                      'Questionnaire',
                      textAlign: TextAlign.center,
                      style: kHeading1.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    ClayContainer(
                        spread: 0,
                        color: Colors.red,
                        parentColor: Color(0xffF2F7FC),
                        depth: 2,
                        width: 100,
                        height: 34,
                        borderRadius: 15,
                        child: Center(
                          child: Text(
                            "Pending",
                            style: kHeading3.copyWith(color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
