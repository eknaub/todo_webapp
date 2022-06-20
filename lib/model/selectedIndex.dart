import 'package:flutter/cupertino.dart';

class SelectedActivity with ChangeNotifier {
  int selectedIndex = -1;

  void setSelectedIndex(int idx) {
    selectedIndex = idx;
    notifyListeners();
  }
}
