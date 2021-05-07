import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/models/books.dart';
import 'package:lms/models/tabs.dart';
import 'package:lms/models/user.dart';
import 'package:lms/services/auth.dart';
import 'package:lms/views/login.dart';
import 'package:lms/widgets/fab.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> loadUser() async {
    bool isLoaded = true;
    var result = await Provider.of<LMSUser>(context, listen: false)
        .getUserFromFirebase(context);
    // await Provider.of<AllFirebaseBooks>(context, listen: false)
    //     .fetchAllFirebaseBooks();
    if (!result) {
      Fluttertoast.showToast(
          msg: "Error connecting to the internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoaded = false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: loadUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return SafeArea(
                  child: Scaffold(
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    Image.asset('assets/images/background.jpg')
                                        .image,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.dstATop),
                                fit: BoxFit.cover),
                          ),
                          child: Provider.of<TabViews>(context).getTabView(),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: [
                                BottomNavigationTabs(
                                  index: 0,
                                  iconData: CupertinoIcons.house_alt,
                                ),
                                BottomNavigationTabs(
                                  index: 1,
                                  iconData: CupertinoIcons.square_favorites_alt,
                                ),
                                Expanded(child: Container()),
                                BottomNavigationTabs(
                                  index: 2,
                                  iconData: CupertinoIcons.cart,
                                ),
                                BottomNavigationTabs(
                                  index: 3,
                                  iconData: CupertinoIcons.person,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: ActionFab(),
                    )
                  ],
                ),
              ));
            } else {
              return Center(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('Retry..')),
              ));
            }
          }
          return Scaffold(
              body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: Image.asset('assets/images/background.jpg').image,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  fit: BoxFit.cover),
            ),
            child: Center(child: CircularProgressIndicator()),
          ));
        });
  }
}

class BottomNavigationTabs extends StatefulWidget {
  int index;
  IconData iconData;
  BottomNavigationTabs({Key? key, required this.index, required this.iconData})
      : super(key: key);

  @override
  _BottomNavigationTabsState createState() => _BottomNavigationTabsState();
}

class _BottomNavigationTabsState extends State<BottomNavigationTabs> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Provider.of<TabViews>(context, listen: false)
              .setTabView(widget.index);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Icon(
            widget.iconData,
            color:
                Provider.of<TabViews>(context, listen: false).selectedIndex ==
                        widget.index
                    ? Colors.green
                    : Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
