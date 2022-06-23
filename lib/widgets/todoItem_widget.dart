import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        hoverColor: Colors.blueGrey[800],
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        mouseCursor: MouseCursor.defer,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            color: widget.task.getTaskProgress() == 1.0
                ? Colors.blueGrey[800]
                : Colors.transparent,
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
                    color: Colors.white,
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
                        backgroundColor: Colors.blueGrey,
                        color: Colors.green,
                      ),
                    )),
                    Center(
                      child: Text(
                        "${widget.task.taskCurrentSteps}/${widget.task.taskSteps}",
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
                    widget.task.incrementProgressOfTask();
                    widget.task.onStateChanged();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              const SizedBox(width: 24),
              Text(
                widget.task.taskDescription,
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
