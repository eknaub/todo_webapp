import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/sharedPrefs/prefs.dart';

class Task {
  final int taskIdx;
  final int taskSteps;
  final int taskCurrentSteps;
  final String taskDescription;
  final Function() onStateChanged; //trigger rebuild if task item changed

  late SelectedActivity activityIdx;

  Task({
    required this.taskIdx,
    required this.taskSteps,
    required this.taskCurrentSteps,
    required this.taskDescription,
    required this.onStateChanged,
  });

  void updateSelectedActivity({required SelectedActivity activityIdx}) {
    this.activityIdx = activityIdx;
  }

  String getActivityName() {
    return sharedPrefs.getActivityName(
        activityIdx: activityIdx.selectedActivityIdx);
  }

  double getTaskProgress() {
    return taskCurrentSteps / taskSteps;
  }

  void decrementProgressOfTask() {
    String activity = getActivityName();
    sharedPrefs.decrementProgressOfTask(activity: activity, taskIdx: taskIdx);
  }

  void incrementProgressOfTask() {
    String activity = getActivityName();
    sharedPrefs.incrementProgressOfTask(activity: activity, taskIdx: taskIdx);
  }

  void removeTask() {
    String activity = getActivityName();
    sharedPrefs.removeTaskFromActivity(activity: activity, taskIdx: taskIdx);
  }
}
