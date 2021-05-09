import 'package:edmissions/views/question.dart';
import 'package:flutter/cupertino.dart';

import '../views/tabs/cart.dart';
import '../views/tabs/dashboard.dart';
import '../views/tabs/history.dart';
import '../views/tabs/user.dart';

class TabViews extends ChangeNotifier {
  int selectedIndex = 0;
  bool showBottomNavigationBar = true;
  void setTabView(int i) {
    selectedIndex = i;
    notifyListeners();
  }

  void setBottomNavigationBar(bool result) {
    showBottomNavigationBar = result;
    notifyListeners();
  }

  Widget getTabView(BuildContext context) {
    Widget ob;
    ob = DashBoardTab();
    switch (selectedIndex) {
      case 0:
        ob = DashBoardTab();
        break;
      case 1:
        ob = HistoryTab();
        break;
      case 2:
        ob = CartTab();
        break;
      case 3:
        ob = UserTab();
        break;
    }
    return ob;
  }
}
