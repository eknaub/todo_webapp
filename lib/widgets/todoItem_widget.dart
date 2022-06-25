import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/constants/colors.dart';
import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/model/task.dart';

class TodoItemWidget extends StatefulWidget {
  final Task task;

  const TodoItemWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late SelectedActivity activityIdx;

  @override
  Widget build(BuildContext context) {
    activityIdx = Provider.of<SelectedActivity>(context);
    widget.task.updateSelectedActivity(activityIdx: activityIdx);
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => {},
        hoverColor: Theme.of(context).primaryColor.withOpacity(0.4),
        splashColor: transparentColor,
        highlightColor: transparentColor,
        mouseCursor: MouseCursor.defer,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: widget.task.getTaskProgress() == 1.0
                ? Theme.of(context).primaryColor.withOpacity(0.4)
                : transparentColor,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    widget.task.decrementProgressOfTask();
                    widget.task.onStateChanged();
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: whiteColor,
                  )),
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Center(
                        child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: 0.0, end: widget.task.getTaskProgress()),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, _) => CircularProgressIndicator(
                        value: value,
                        backgroundColor: Theme.of(context).primaryColor,
                        color: greenColor,
                      ),
                    )),
                    Center(
                      child: Text(
                        "${widget.task.taskCurrentSteps}/${widget.task.taskSteps}",
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    widget.task.incrementProgressOfTask();
                    widget.task.onStateChanged();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: whiteColor,
                  )),
              const SizedBox(width: 24),
              Text(
                widget.task.taskDescription,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 14.0,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete, color: whiteColor),
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
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).errorColor),
            ),
            onPressed: () {
              widget.task.removeTask();
              widget.task.onStateChanged(); //update state of parent widget
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
