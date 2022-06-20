import 'package:flutter/cupertino.dart';

class SelectedActivity with ChangeNotifier {
  int selectedActivityIdx = -1;

  void setSelectedIndex(int idx) {
    selectedActivityIdx = idx;
    notifyListeners();
  }
}
