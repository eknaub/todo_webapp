import 'package:todo_webapp/sharedPrefs/prefs.dart';

import 'activity.dart';

class ActivityList {
  final List<Activity> _activities = [];

  ActivityList() {
    var list = sharedPrefs.getAllActivityNames();
    for (var item in list) {
      _activities.add(Activity(activity: item));
    }
  }

  List<Activity> get activities => _activities;

  int length() => _activities.length;

  String getActivityAt({required int index}) {
    String activity = _activities[index].activity;
    return activity;
  }

  void removeAt({required int index}) {
    sharedPrefs.removeActivity(activity: _activities[index].activity);
    _activities.removeAt(index);
  }

  void add({required String activity}) {
    _activities.add(Activity(activity: activity));
    sharedPrefs.addActivity(activity: activity);
  }

  bool contains({required String activity}) {
    for (var item in _activities) {
      if (activity == item.activity) {
        return true;
      }
    }
    return false;
  }
}
