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

  List<dynamic> getTasksForActivity({required int activityIdx}) {
    String activity = getActivityName(activityIdx: activityIdx);
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
    String activity = getActivityName(activityIdx: activityIdx);
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    List list = [taskIdx, steps, currSteps, description];
    tasks.add(list);
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  void incrementProgressOfTask({
    required int taskIdx,
    required int activityIdx,
  }) {
    String activity = getActivityName(activityIdx: activityIdx);
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    for (var task in tasks) {
      if (task[0] == taskIdx) {
        if (task[1] != task[2]) {
          task[2]++;
        }
        break;
      }
    }
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  void decrementProgressOfTask({
    required int taskIdx,
    required int activityIdx,
  }) {
    String activity = getActivityName(activityIdx: activityIdx);
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    for (var task in tasks) {
      if (task[0] == taskIdx) {
        if (task[2] > 0) {
          task[2]--;
        }
        break;
      }
    }
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  double getTotalProgressForActivity({
    required int activityIdx,
  }) {
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    double totalProgress = 0.0;
    double currentProgress = 0.0;
    //add to currentProgress only if task is 100% done
    for (var task in tasks) {
      if (task[1] == task[2]) {
        currentProgress += task[2];
      }
      totalProgress += task[1];
    }

    if (currentProgress != 0) {
      return currentProgress / totalProgress;
    }

    return 0;
  }

  void resetProgressFromAllTasksForActivity({
    required int activityIdx,
  }) {
    String activity = getActivityName(activityIdx: activityIdx);
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    for (var task in tasks) {
      task[2] = 0;
    }
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  void removeTaskFromActivity(
      {required int activityIdx, required int taskIdx}) {
    String activity = getActivityName(activityIdx: activityIdx);
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    for (var task in tasks) {
      if (task[0] == taskIdx) {
        tasks.remove(task);
        break;
      }
    }
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  void removeAllTasksFromActivity({required int activityIdx}) {
    String activity = getActivityName(activityIdx: activityIdx);
    var tasks = getTasksForActivity(activityIdx: activityIdx);
    tasks.clear();
    final s = jsonEncode(tasks);
    sharedPrefs.instance.setString("${activity}Tasks", s);
  }

  String getActivityName({required int activityIdx}) {
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

  void addActivity({required String activity}) {
    late List<String>? items = getAllActivityNames();
    items?.add(activity);
    sharedPrefs.instance.setStringList('activities', items!);
  }

  void removeActivity({required String activity, required int activityIdx}) {
    late List<String>? items = getAllActivityNames();
    items?.remove(activity);
    removeAllTasksFromActivity(activityIdx: activityIdx);
    sharedPrefs.instance.setStringList('activities', items!);
  }
}
