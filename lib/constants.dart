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

final kProcessMessage =
    '''1. Fill in the common application form using the EdMissions App and click on apply button.\n
    2. Pay the one time admission charge.\n
    3. When accepted you will be informed about the video interview process.\n
    4. Take a printout of admission form for future reference\n
    5. For any query, reach out to us on the contact listed below.''';

final kAboutMessage =
    '''We here in St. Thomas deem it as a privilege to greet you all and welcome you to browse through the website of St. Thomas School, Ranchi located at Dhurwa, Ranchi.
       We are a premier educational institution founded in 1972 trusting upon God and his immeasurable grace.
       The Mar Thoma Syrian Church of Malabar laid its foundation in Ranchi with a small group of about 40 families with Rev. Dr. P. M. Mathew as the Vicar. The church took it as a mission to start a new English Medium School in the HEC Campus which would benefit the children of the employees of the HEC.
The origin of the school finds its roots in an announcement in 1971 by HEC (Heavy Engineering Corporation) Board of Directors headed by the Managing Director Mr. M. L. Wadhera inviting institutions and interested parties to set up schools for the benefit of children of the employees of HEC.
The first building 60 feet long was ready by the end of December 1972 under the stewardship of the Vicar and technical assistance of Mr. H. M. Abraham and Mr. Jacob John.
In January 1973, the ST.Thomas School was inaugurated with Kindergarten classes by Brig. B.N.Upadhyay, the then Chief of Personnel HEC, Rt. Rev. Dr. Alexander Mar Theophilus Episcopa presided.
The Parish General body decided to form a society to own and manage the school. A provisional executive body was formed with the Vicar as its President and Mr. George E. Mathew as treasurer to look after the management of the school and organize the proposed society. A constitution and Rules and Regulation for the society were drawn up with the approval of the Parish. A society made under the name ‘Mar Thoma Educational Society, Bihar’, Ranchi was registered with the government of Bihar under the Societies’ Registration Act. The ownership and management of the school was then entrusted with this Society.
The second building 100 ft. loon was constructed and made available to start the next school session in January 1974. The school with 400 students and 9 teachers till Std. IV started working. With the passage of time the school building was constructed as the strength of the school kept on increasing and today the strength stands at 3,801 with students from KG I to Std X (79 classes altogether).
       ''';

final kShowToast = Fluttertoast.showToast(
    msg: "Copied!",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.pink,
    textColor: Colors.black,
    fontSize: 12.0);

final String kDpParentUrl = 'gs://edmissions-211e5.appspot.com//dp/';
