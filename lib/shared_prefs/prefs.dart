import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = Preferences.prefs;

class Preferences {
  static final Preferences _prefs = Preferences();
  static Preferences get prefs => _prefs;
  late SharedPreferences instance;

  Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  List<dynamic> getTasksForActivity(int activityIdx) {
    String activity = getCurrentActivityName(activityIdx);
    String? tasks = sharedPrefs.instance.getString("${activity}Tasks");
    List<dynamic> taskList = [];
    if (tasks != null) {
      taskList = jsonDecode(tasks);
    }

    return taskList;
  }

  void addTaskToActivity(
      {required int taskIdx,
      required int activityIdx,
      required String description,
      required int steps,
      required int currSteps}) {
    String activity = getCurrentActivityName(activityIdx);
    var tasks = getTasksForActivity(activityIdx);
    List list = [taskIdx, steps, currSteps, description];
    tasks.add(list);
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  void removeTaskFromActivity(
      {required int activityIdx, required int taskIdx}) {
    String activity = getCurrentActivityName(activityIdx);
    var tasks = getTasksForActivity(activityIdx);
    for (var task in tasks) {
      if (task[0] == taskIdx) tasks.remove(task);
    }
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  void removeAllTasksFromActivity({required int activityIdx}) {
    String activity = getCurrentActivityName(activityIdx);
    var tasks = getTasksForActivity(activityIdx);
    tasks.clear();
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  String getCurrentActivityName(int activityIdx) {
    late List<String>? items;
    items = sharedPrefs.instance.getStringList('activities');
    return items![activityIdx];
  }

  List<String>? getAllActivityNames() {
    late List<String>? items;
    items = sharedPrefs.instance.getStringList('activities');
    items ??= [];
    return items;
  }

  void addActivity(String activity) {
    late List<String>? items = getAllActivityNames();
    items?.add(activity);
    sharedPrefs.instance.setStringList('activities', items!);
  }

  void removeActivity(String activity) {
    late List<String>? items = getAllActivityNames();
    items?.remove(activity);
    sharedPrefs.instance.setStringList('activities', items!);
  }
}
