import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/shared_prefs/prefs.dart';

class TodoItemWidget extends StatefulWidget {
  final int taskIdx;
  final String taskDescription;
  final int taskSteps;
  final int taskCurrentSteps;
  final Function() onStateChanged; //trigger rebuild if task item changed

  /*
  0 = taskIdx
  1 = taskSteps
  2 = taskCurrentSteps
  3 = taskDescription
   */
  const TodoItemWidget({
    Key? key,
    required this.taskIdx,
    required this.taskDescription,
    required this.taskSteps,
    required this.taskCurrentSteps,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late SelectedActivity activityIdx;
  late double taskProgress = 0.0;
  late String activityName = '';

  @override
  Widget build(BuildContext context) {
    activityIdx = Provider.of<SelectedActivity>(context);
    activityName = sharedPrefs.getActivityName(
        activityIdx: activityIdx.selectedActivityIdx);
    taskProgress = widget.taskCurrentSteps / widget.taskSteps;
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => {},
        hoverColor: Colors.blueGrey[800],
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        mouseCursor: MouseCursor.defer,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            color:
                taskProgress == 1.0 ? Colors.blueGrey[800] : Colors.transparent,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    sharedPrefs.decrementProgressOfTask(
                        activity: activityName, taskIdx: widget.taskIdx);
                    widget.onStateChanged();
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Center(
                        child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: taskProgress),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, _) => CircularProgressIndicator(
                        value: value,
                        backgroundColor: Colors.blueGrey,
                        color: Colors.green,
                      ),
                    )),
                    Center(
                      child: Text(
                        "${widget.taskCurrentSteps}/${widget.taskSteps}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    sharedPrefs.incrementProgressOfTask(
                        activity: activityName, taskIdx: widget.taskIdx);
                    widget.onStateChanged();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              const SizedBox(width: 24),
              Text(
                widget.taskDescription,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () => _removeActivityDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _removeActivityDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Remove task'),
        content: const Text('Are you sure you want to remove this task?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              sharedPrefs.removeTaskFromActivity(
                  activity: activityName, taskIdx: widget.taskIdx);
              widget.onStateChanged(); //update state of parent widget
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
