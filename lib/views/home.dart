import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tabs.dart';
import '../themes.dart';
import '../widgets/fab.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> loadUser() async {
    /**
     * TODO:
     * Fetch user data/state to show within the application. show a network error toast in case, the data couldn't be loaded.
     */
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
                        Expanded(
                          flex: 15,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 100,
                            decoration: BoxDecoration(
                              image: kBackgroundImage,
                            ),
                            child: Provider.of<TabViews>(context)
                                .getTabView(context),
                          ),
                        ),
                        Provider.of<TabViews>(context, listen: false)
                                .showBottomNavigationBar
                            ? Expanded(
                                flex: 2,
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
                                        iconData:
                                            CupertinoIcons.square_favorites_alt,
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
                            : Container()
                      ],
                    ),
                    Provider.of<TabViews>(context, listen: false)
                            .showBottomNavigationBar
                        ? Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: ActionFab(),
                          )
                        : Container()
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
              image: kBackgroundImage,
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
