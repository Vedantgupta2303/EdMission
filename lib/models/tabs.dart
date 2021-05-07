import 'package:flutter/cupertino.dart';
import 'package:lms/views/tabs/cart.dart';
import 'package:lms/views/tabs/dashboard.dart';
import 'package:lms/views/tabs/history.dart';
import 'package:lms/views/tabs/user.dart';

class TabViews extends ChangeNotifier {
  int selectedIndex = 0;

  void setTabView(int i) {
    selectedIndex = i;
    notifyListeners();
  }

  Widget getTabView() {
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
