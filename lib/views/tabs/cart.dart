import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/clayContainerHighlight.dart';
import '../../widgets/submitBtn.dart';
import 'user.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
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
                'Cart',
                style: kHeading1,
              ),
              ClayContainer(
                  color: Colors.green,
                  parentColor: Color(0xffF2F7FC),
                  depth: 2,
                  width: 100,
                  height: 40,
                  borderRadius: 15,
                  child: Center(
                    child: Text(
                      " ",
                      style: kHeading3.copyWith(color: Colors.white),
                    ),
                  ))
            ],
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   child: ListView.builder(
          //       itemCount: 4,
          //       shrinkWrap: true,
          //       physics: NeverScrollableScrollPhysics(),
          //       itemBuilder: (context, index) {
          //         return Container(
          //           clipBehavior: Clip.antiAlias,
          //           margin: EdgeInsets.only(bottom: 10),
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Color(0xff6683AB).withOpacity(0.2),
          //                 offset: const Offset(
          //                   0.0,
          //                   0.0,
          //                 ),
          //                 blurRadius: 15.0,
          //                 spreadRadius: 2.0,
          //               ), //BoxShadow
          //               BoxShadow(
          //                 color: Colors.white,
          //                 offset: const Offset(0.0, 0.0),
          //                 blurRadius: 1.0,
          //                 spreadRadius: 0.0,
          //               ), //BoxShadow
          //             ],
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: ListTile(
          //             tileColor: Color(0xffF2F7FC),
          //             dense: true,
          //             title: Text(
          //               'Java the Complete Reference',
          //               overflow: TextOverflow.ellipsis,
          //               style: kHeading3,
          //             ),
          //             subtitle: Text(
          //               'Herbert Schlidt',
          //               style: kHeading4,
          //             ),
          //             trailing: ClayContainerHighlight(
          //               iconData: CupertinoIcons.arrow_right,
          //             ),
          //             leading: Image.network(
          //                 "https://images-na.ssl-images-amazon.com/images/I/618YQosPQTL.jpg"),
          //           ),
          //         );
          //       }),
          // ),
          // SizedBox(height: 10),
          // SubmitButton(text: 'Checkout', onTap: () {}),
          // SizedBox(height: 20),
          // Divider(
          //   color: Colors.blueGrey,
          //   height: 2,
          //   thickness: 2,
          // ),
          // SizedBox(height: 20),
          // Text(
          //   'Wishlist',
          //   style: kHeading3,
          // ),
          // SizedBox(height: 20),
          // ListView.builder(
          //     itemCount: 2,
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: EdgeInsets.only(bottom: 20),
          //         child: FrostedGlassUserInfo(
          //             showActionButton: true,
          //             color: Colors.pink.shade200,
          //             title: 'Java the complete reference',
          //             subtitle: 'Herbert Schlidt'),
          //       );
          //     })
        ],
      ),
    );
  }
}
