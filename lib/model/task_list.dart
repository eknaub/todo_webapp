import 'package:todo_webapp/model/selected_activity.dart';
import 'package:todo_webapp/model/task.dart';
import 'package:todo_webapp/sharedPrefs/prefs.dart';

class TaskList {
  final List<Task> _tasks = [];
  late SelectedActivity activityIdx;

  List<Task> get tasks => _tasks;

  int length() => _tasks.length;

  void updateSelectedActivity({required SelectedActivity activityIdx}) {
    this.activityIdx = activityIdx;
  }

  String getActivityName() {
    return sharedPrefs.getActivityName(
        activityIdx: activityIdx.selectedActivityIdx);
  }

  double getTotalTaskProgress() {
    String activity = getActivityName();
    return sharedPrefs.getTotalProgressForActivity(activity: activity);
  }

  String getTotalTaskProgressAsString() {
    double taskProgress = getTotalTaskProgress();
    return (taskProgress * 100).toStringAsFixed(0);
  }

  void updateTasks({required Function() onStateChanged}) {
    _tasks.clear();
    String activity = getActivityName();
    List<dynamic> activityTaskData = getTasksForActivity(activity: activity);

    for (var task in activityTaskData) {
      _tasks.add(Task(
          taskIdx: task[0],
          taskSteps: task[1],
          taskCurrentSteps: task[2],
          taskDescription: task[3],
          onStateChanged: onStateChanged));
    }
  }

  List<dynamic> getTasksForActivity({required String activity}) {
    return sharedPrefs.getTasksForActivity(activity: activity);
  }

  void add(
      {required int taskSteps,
      required String taskDescription,
      required Function() onStateChanged}) {
    String activity = getActivityName();
    List<dynamic> activityTaskData = getTasksForActivity(activity: activity);

    tasks.add(
      Task(
          taskIdx: activityTaskData.length,
          taskDescription: taskDescription,
          taskSteps: taskSteps,
          taskCurrentSteps: 0,
          onStateChanged: onStateChanged),
    );

    sharedPrefs.addTaskToActivity(
        taskIdx: activityTaskData.length,
        activity: activity,
        description: taskDescription,
        steps: taskSteps,
        currSteps: 0);
  }

  void removeAll() {
    String activity = getActivityName();
    sharedPrefs.removeAllTasksFromActivity(activity: activity);
    _tasks.clear();
  }

  void resetAllProgress() {
    String activity = getActivityName();
    sharedPrefs.resetProgressFromAllTasksForActivity(activity: activity);
  }
}
