import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/constants.dart';
import 'package:lms/views/tabs/user.dart';
import 'package:lms/widgets/clayContainerHighlight.dart';
import 'package:lms/widgets/submitBtn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SearchResultsTab extends StatefulWidget {
  String title;
  String description;
  String imageUrl;
  String rating;
  String publisher;
  String publishedDate;
  int pageCount;
  String isbn_10;
  String isbn_13;
  List<String> authors;
  SearchResultsTab(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.isbn_10,
      required this.isbn_13,
      required this.pageCount,
      required this.publishedDate,
      required this.publisher,
      required this.rating,
      required this.authors});
  @override
  _SearchResultsTabState createState() => _SearchResultsTabState();
}

class _SearchResultsTabState extends State<SearchResultsTab> {
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
                widget.title,
                style: kPageTitleTextStyle,
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
                      "3/4 books",
                      style:
                          kPageHeading3TextStyle.copyWith(color: Colors.white),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff6683AB).withOpacity(0.2),
                          offset: const Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 15.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      tileColor: Color(0xffF2F7FC),
                      dense: true,
                      title: Text(
                        'Java the Complete Reference',
                        overflow: TextOverflow.ellipsis,
                        style: kPageHeading3TextStyle,
                      ),
                      subtitle: Text(
                        'Herbert Schlidt',
                        style: kPageSecondaryTextStyle,
                      ),
                      trailing: ClayContainerHighlight(
                        iconData: CupertinoIcons.arrow_right,
                      ),
                      leading: Image.network(
                          "https://images-na.ssl-images-amazon.com/images/I/618YQosPQTL.jpg"),
                    ),
                  );
                }),
          ),
          SizedBox(height: 10),
          SubmitButton(text: 'Checkout', onTap: () {}),
          SizedBox(height: 20),
          Divider(
            color: Colors.blueGrey,
            height: 2,
            thickness: 2,
          ),
          SizedBox(height: 20),
          Text(
            'Wishlist',
            style: kPageHeading3TextStyle,
          ),
          SizedBox(height: 20),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FrostedGlassUserInfo(
                      showActionButton: true,
                      color: Colors.pink.shade200,
                      title: 'Java the complete reference',
                      subtitle: 'Herbert Schlidt'),
                );
              })
        ],
      ),
    );
  }
}
