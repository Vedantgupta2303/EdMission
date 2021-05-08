import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/submitBtn.dart';
import 'user.dart';

// class HistoryTab extends StatefulWidget {
//   @override
//   _HistoryTabState createState() => _HistoryTabState();
// }

// class _HistoryTabState extends State<HistoryTab> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Page 2',
//                 style: kHeading1,
//               ),
//               ClayContainer(
//                   color: Colors.amber.shade600,
//                   parentColor: Color(0xffF2F7FC),
//                   depth: 2,
//                   width: 100,
//                   height: 40,
//                   borderRadius: 15,
//                   child: Center(
//                     child: Text(
//                       " ",
//                       style: kHeading3.copyWith(color: Colors.white),
//                     ),
//                   ))
//             ],
//           ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // Text(
//           //   'Current Borrowings',
//           //   style: kHeading3,
//           // ),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           // SubmitButton(
//           //   isActionEnabled: true,
//           //   height: 100,
//           //   text: 'Due Date : 15-Apr-2021',
//           //   onTap: () {},
//           //   pColor: Colors.green.shade600.withAlpha(200),
//           // ),
//           // SizedBox(height: 20),
//           // Divider(
//           //   color: Colors.blueGrey,
//           //   height: 2,
//           //   thickness: 2,
//           // ),
//           // SizedBox(height: 20),
//           // Text(
//           //   'Previous Transactions',
//           //   style: kHeading3,
//           // ),
//           // SizedBox(height: 20),
//           // ListView.builder(
//           //     itemCount: 5,
//           //     shrinkWrap: true,
//           //     physics: NeverScrollableScrollPhysics(),
//           //     itemBuilder: (context, index) {
//           //       return Container(
//           //         margin: EdgeInsets.only(bottom: 20),
//           //         child: FrostedGlassUserInfo(
//           //             iconData: CupertinoIcons.arrow_right,
//           //             showActionButton: true,
//           //             color: Colors.amber.shade400,
//           //             title: 'Issued : 27-Mar-2021',
//           //             subtitle: 'Returned : 5-Apr-2021'),
//           //       );
//           //     })
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../src/pages/index.dart';

class HistoryTab extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
