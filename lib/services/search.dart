import 'package:books_finder/books_finder.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/constants.dart';
import 'package:lms/views/tabs/user.dart';
import 'package:lms/widgets/clayContainerHighlight.dart';
import 'package:lms/widgets/submitBtn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:lms/models/books.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends ChangeNotifier {
  List<FirebaseBooks> recentSearches = [];
  String query = "";

  void updateRecentSearches(FirebaseBooks one) {
    if (recentSearches.length == 0) {
      recentSearches.insert(0, one);
    } else if (recentSearches.length == 1) {
      recentSearches.insert(1, recentSearches[0]);
      recentSearches[0] = one;
    } else if (recentSearches.length == 2) {
      recentSearches[1] = recentSearches[0];
      recentSearches[0] = one;
    }

    notifyListeners();
  }

  void globlSearch() {}

  void localSearch() {}
}

class BookSearch extends SearchDelegate<String?> {
  late FirebaseBooks firebaseSearchDocument = FirebaseBooks();
  late FirebaseBooks globalSearchDocument = FirebaseBooks();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 1,
        brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: GoogleFonts.roboto(color: Colors.blueGrey.shade400),
            border: InputBorder.none,
          ),
    );
  }

  Widget getShelfItems(List<FirebaseBooks> results) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: results.length <= 5 ? results.length : 5,
          itemBuilder: (context, index) {
            final suggestion = results[index].title;
            var queryText = suggestion;
            var remainingText = suggestion;
            if (suggestion != '') {
              queryText = suggestion.substring(0, query.length);
              remainingText = suggestion.substring(query.length);
            }

            if (suggestion != '')
              return InkWell(
                onTap: () {
                  query = suggestion;
                  firebaseSearchDocument = results[index];
                  Provider.of<Search>(context, listen: false)
                      .updateRecentSearches(results[index]);
                  showResults(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: SubmitButton(
                    isNumberEnabled: true,
                    number: results[index].availability,
                    subtitle: results[index].description,
                    pColor: Colors.pink.shade100,
                    richText: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: queryText,
                        style: GoogleFonts.montserrat(
                          color: Colors.pink.shade200,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: remainingText,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                    isActionEnabled: true,
                    text: '',
                  ),
                ),
              );
            else
              return Container();
          }),
    );
  }

  Widget FirebaseSearchResults() {
    return StreamBuilder<QuerySnapshot>(
      initialData: null,
      stream: FirebaseFirestore.instance.collection('books').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CupertinoActivityIndicator());
        }

        if (query == '') {
          var recentBooks =
              Provider.of<Search>(context, listen: false).recentSearches;
          return Container(
            child: Column(
              children: [
                Text(
                  'Recent Items',
                  style: kPageSubtitleTextStyle,
                ),
                SizedBox(height: 10),
                recentBooks == []
                    ? Container()
                    : Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recentBooks.length,
                            itemBuilder: (context, index) {
                              final suggestion = recentBooks[index].title;
                              var queryText = suggestion;
                              var remainingText = suggestion;
                              if (suggestion != '') {
                                queryText =
                                    suggestion.substring(0, query.length);
                                remainingText =
                                    suggestion.substring(query.length);
                              }

                              if (suggestion != '')
                                return InkWell(
                                  onTap: () {
                                    query = suggestion;
                                    firebaseSearchDocument = recentBooks[index];
                                    showResults(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: SubmitButton(
                                      isNumberEnabled: true,
                                      number: recentBooks[index].availability,
                                      subtitle: recentBooks[index].description,
                                      pColor: Colors.pink.shade100,
                                      richText: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: queryText,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.pink.shade200,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: remainingText,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                      isActionEnabled: true,
                                      text: '',
                                    ),
                                  ),
                                );
                              else
                                return Container();
                            }),
                      )
              ],
            ),
          );
        }
        var results = snapshot.data!.docs
            .where((a) =>
                a.data().toString().toLowerCase().contains(query.toLowerCase()))
            .toList();

        List<FirebaseBooks> firebaseBookList = [];
        for (var item in results) {
          firebaseBookList.add(FirebaseBooks.getBookFromFirebase(item));
        }

        return getShelfItems(firebaseBookList);
      },
    );
  }

  Widget GlobalSearchResults() {
    return FutureBuilder<List<Book>>(
      initialData: null,
      future: queryBooks(query,
          startIndex: 0,
          maxResults: 8,
          printType: PrintType.books,
          orderBy: OrderBy.relevance),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (query == '')
            return Center(
              child: Text('Enter a keyword to search..'),
            );
          return Center(child: CupertinoActivityIndicator());
        }
        List<FirebaseBooks> firebaseBooksList = [];
        if (snapshot.data != null) {
          for (var item in snapshot.data!.toList()) {
            firebaseBooksList.add(FirebaseBooks.getFirebaseFromBook(item));
          }
        }
        // for (var item in results) print(item.info.authors);
        // return Container();
        return snapshot.data == null || firebaseBooksList.length == 0
            ? Container()
            : Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: firebaseBooksList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: firebaseBooksList[index].imageLinks.length != 0
                            ? Image.network(firebaseBooksList[index]
                                .imageLinks[0]
                                .toString())
                            : Text(''),
                        onTap: () {
                          query = firebaseBooksList[index].title;
                          globalSearchDocument = firebaseBooksList[index];
                          showResults(context);
                        },
                        minVerticalPadding: 10,
                        tileColor: Colors.grey.shade200,
                        title: Text(
                          firebaseBooksList[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kPageSecondaryTextStyle,
                        ),
                        subtitle: Text(
                          firebaseBooksList[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.abel(fontSize: 14),
                        ),
                        trailing: ClayContainerHighlight(
                          iconData: CupertinoIcons.arrow_right,
                          isSpreadAllowed: false,
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.amber,
        ),
        onPressed: () {
          // addDocToFirebase();
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    FirebaseBooks result = FirebaseBooks();
    result = globalSearchDocument.title == query
        ? globalSearchDocument
        : firebaseSearchDocument;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              globalSearchDocument.title == query
                  ? Container()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: ClayContainer(
                          color: Colors.green,
                          parentColor: Color(0xffF2F7FC),
                          depth: 2,
                          width: (MediaQuery.of(context).size.width - 40),
                          height: 40,
                          borderRadius: 15,
                          child: Center(
                            child: Text(
                              'Copies available in the Library : ' +
                                  result.availability.toString(),
                              style: kPageHeading3TextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          )),
                    ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                                value: progress.progress));
                      },
                      height: 200,
                      width: 200,
                      imageUrl: result.imageLinks[1]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  result.title,
                  style: kPageTitleTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  result.authors.join(", "),
                  style: kPageSubtitleTextStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  result.description,
                  style: kPageSecondaryTextStyle,
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.blueGrey,
                height: 2,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Rating :  ' + result.averageRating.toString() + " / 5.0",
                  style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Pages :  ' + result.pageCount.toString() + " pages",
                  style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Publisher :  ' + result.publisher.toString(),
                  style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Language :  ' + result.language.toString(),
                  style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Published Date :  ' + result.publishedDate.substring(0, 10),
                  style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(right: 4.0),
                child: Text(
                  'Categories :  ' + result.categories.join(", "),
                  style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 10),
              result.industryIdentifier.length == 0
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(right: 4.0),
                      child: Text(
                        'ISBN-10:  ' +
                            result.industryIdentifier[0]
                                .toString()
                                .substring(8),
                        style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                      ),
                    ),
              SizedBox(height: 10),
              result.industryIdentifier.length < 2
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(right: 4.0),
                      child: Text(
                        'ISBN-13:  ' +
                            result.industryIdentifier[1]
                                .toString()
                                .substring(8),
                        style: kPageSecondaryTextStyle.copyWith(fontSize: 17),
                      ),
                    ),
              SizedBox(height: 20),
              Divider(
                color: Colors.blueGrey,
                height: 2,
                thickness: 2,
              ),
              SizedBox(height: 20),
              globalSearchDocument.title == query
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: FrostedGlassUserInfo(
                          // showActionButton: true,
                          color: Colors.pink.shade200,
                          title: 'Add To Wishlist',
                          subtitle: ''),
                    )
            ],
          ),
        ),
        globalSearchDocument.title == query
            ? Container()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.bottomCenter,
                child: SubmitButton(text: 'Add to Cart', onTap: () {})),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Library Shelf',
            style: kPageHeading3TextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          FirebaseSearchResults(),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Global Search',
            style: kPageHeading3TextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          GlobalSearchResults()
        ],
      ),
    );
  }

  void addDocToFirebase() async {
    await FirebaseFirestore.instance.collection('books').get().then((value) {
      var docs = value.docs;
      for (var doc in docs) {
        doc.reference.get().then((value) {
          List<String> temp = [];
          RegExp exp = RegExp(r"ISBN.*?[,\]]?(?=[,\]])");
          String uri = value.get('industryIdentifier');
          Iterable<Match> matches = exp.allMatches(uri);
          for (Match item in matches) {
            // print(item[0].runtimeType);
            temp.add(item[0]!);
          }
          value.reference.update({'industryIdentifier': temp});
        });
      }
    }).catchError((err) => print(err));
    // .add({
    //   'title': globalSearchDocument.title,
    //   'authors': globalSearchDocument.authors,
    //   'publisher': globalSearchDocument.publisher,
    //   'publishedDate': globalSearchDocument.publishedDate,
    //   'description': globalSearchDocument.description,
    //   'pageCount': globalSearchDocument.pageCount,
    //   'categories': globalSearchDocument.categories,
    //   'averageRating': globalSearchDocument.averageRating,
    //   'industryIdentifier':
    //       globalSearchDocument.industryIdentifier.toString(),
    //   'imageLinks': globalSearchDocument.imageLinks.toString(),
    //   'language': globalSearchDocument.language,
    // })
    // .then((value) => {print('sent data id : $value')})
    // .catchError((err) => print(err));
  }
}
