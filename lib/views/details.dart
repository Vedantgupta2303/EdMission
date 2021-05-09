import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clipboard/clipboard.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

import '../constants.dart';
import '../src/pages/index.dart';
import '../themes.dart';
import '../widgets/clayContainerHighlight.dart';
import '../widgets/submitBtn.dart';

final List<String> imgList = [
  'assets/images/sts-details.jpg',
  'assets/images/sts-details2.jpg',
  'assets/images/sts-details3.jpg',
  'assets/images/dps-details.jpg',
  'assets/images/dps-details2.jpg',
  'assets/images/jvm-details.jpg',
];

final data = {
  'name': 'St. Thomas School',
  'address': 'Dhurwa, Ranchi, Jharkhand 834004',
  'vacancies': '108 Seats',
  'class': 'XI',
  'lastDate': '22nd May, 2021'
};

final sharedData =
    '''St. Thomas School, Dhurwa, Ranchi, Jharkhand 834004 has opened vacancies of 108 seats for class XI. Apply by 22nd May, 2021 using the following link : www.edmissions.com/register''';

class SchoolDetailsPage extends StatefulWidget {
  static String id = 'details';
  @override
  _SchoolDetailsPageState createState() => _SchoolDetailsPageState();
}

class _SchoolDetailsPageState extends State<SchoolDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: kBackgroundImage,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 200),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        SchoolDetailsTopBar(),
                        SchoolDetailsCaraousel(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SchoolDetailsStatus(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text('Dhurwa, Ranchi, Jharkhand 834004'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          Share.share(sharedData);
                                        },
                                        icon: Icon(
                                          Icons.ios_share,
                                          size: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InformationTile(
                                isExpanded: true,
                                title: 'Current Openings',
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Class XI',
                                          style: kHeading4,
                                        ),
                                        Text(
                                          '108 seats',
                                          style: kHeading3,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Apply by : 22nd May, 2021',
                                        style: kHeading4.copyWith(
                                            color: Colors.orange.shade600))
                                  ],
                                ),
                              ),
                              InformationTile(
                                isExpanded: false,
                                title: 'Process details',
                                content: RichText(
                                  text: TextSpan(
                                      text: kProcessMessage, style: kHeading4),
                                ),
                              ),
                              InformationTile(
                                isExpanded: false,
                                title: 'About',
                                content: RichText(
                                  text: TextSpan(
                                      text: kAboutMessage, style: kHeading4),
                                ),
                              ),
                              InformationTile(
                                isExpanded: false,
                                title: 'Contact us',
                                content: Column(
                                  children: [
                                    CopiableContacts(
                                        icondata: CupertinoIcons.phone,
                                        content: '(+91) 0651-2446649'),
                                    CopiableContacts(
                                        icondata: CupertinoIcons.videocam,
                                        content: '2osjJF7Guw'),
                                    CopiableContacts(
                                        icondata: CupertinoIcons.envelope,
                                        content:
                                            'stthomasschoolranchi@gmail.com'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SubmitButton(text: 'Apply', onTap: () {}))
          ],
        ),
      ),
    ));
  }
}

class CopiableContacts extends StatelessWidget {
  String content;
  IconData icondata;

  CopiableContacts({required this.content, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            icondata,
            size: 16,
          ),
        ),
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(text: content, style: kHeading4),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 50),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              CupertinoIcons.doc_on_doc,
              size: 18,
            ),
            onPressed: () {
              print('tapped');
              FlutterClipboard.copy(content).then((value) => {
                    Fluttertoast.showToast(
                        msg: "Copied!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 12.0)
                  });
            },
          ),
        ),
      ],
    );
  }
}

class InformationTile extends StatelessWidget {
  String title;
  bool isExpanded = false;
  Widget content;
  InformationTile(
      {required this.content, required this.title, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return ExpansionWidget(
        initiallyExpanded: isExpanded,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
              onTap: () => toogleFunction(animated: true),
              child: ClayContainer(
                spread: 0,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(title)),
                      Transform.rotate(
                        angle: math.pi * animationValue / 2,
                        child: Icon(CupertinoIcons.arrow_right, size: 20),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              ));
        },
        content: Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          padding: EdgeInsets.all(20),
          child: content,
        ));
  }
}

class SchoolDetailsStatus extends StatelessWidget {
  const SchoolDetailsStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'St. Thomas School',
            style: kHeading1,
          ),
        ),
        Expanded(
          flex: 1,
          child: ClayContainer(
              color: Colors.green,
              parentColor: Color(0xffF2F7FC),
              depth: 2,
              width: 100,
              height: 40,
              borderRadius: 15,
              child: Center(
                child: Text(
                  "Open",
                  style: kHeading3.copyWith(color: Colors.white),
                ),
              )),
        )
      ],
    );
  }
}

class SchoolDetailsCaraousel extends StatelessWidget {
  const SchoolDetailsCaraousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: imgList
              .map((item) => Container(
                    child: Center(
                        child: Image.asset(item,
                            height: 200, fit: BoxFit.cover, width: 1000)),
                  ))
              .toList(),
        ));
  }
}

class SchoolDetailsTopBar extends StatelessWidget {
  const SchoolDetailsTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClayContainerHighlight(
            iconData: CupertinoIcons.arrow_left,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ClayContainerHighlight(
            iconData: CupertinoIcons.camera,
            onTap: () {
              Navigator.pushNamed(context, IndexPage.id);
            },
          ),
        ],
      ),
    );
  }
}
