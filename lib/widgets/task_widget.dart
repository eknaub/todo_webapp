import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/model/taskList.dart';
import 'package:todo_webapp/widgets/todoItem_widget.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController _taskDescriptionController;
  late TextEditingController _taskStepsController;
  late SelectedActivity activityIdx;
  late TaskList taskItems;

  @override
  void initState() {
    super.initState();
    _taskDescriptionController = TextEditingController();
    _taskStepsController = TextEditingController();
    taskItems = TaskList();
  }

  @override
  void dispose() {
    _taskDescriptionController.dispose();
    _taskStepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    activityIdx = Provider.of<SelectedActivity>(context);
    taskItems.updateSelectedActivity(activityIdx: activityIdx);
    taskItems.updateTasks(onStateChanged: () {
      setState(() {});
    });
    return Column(
      children: [
        Text(
          taskItems.getActivityName(),
          style: const TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              label: const Text(
                "New task",
              ),
              icon: const Icon(Icons.add),
              onPressed: () => _addTaskDialog(context),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              icon: const Icon(Icons.refresh),
              label: const Text(
                "Reset all tasks",
              ),
              onPressed: () => _resetAllTasksDialog(context),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              icon: const Icon(Icons.delete),
              label: const Text(
                "Remove all tasks",
              ),
              onPressed: () => _removeAllTasksDialog(context),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Stack(children: [
          SizedBox(
              height: 20,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                    begin: 0.0, end: taskItems.getTotalTaskProgress()),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.blueGrey,
                  color: Colors.green,
                ),
              )),
          Center(
            child: Text(
              "${taskItems.getTotalTaskProgressAsString()}% complete",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          )
        ]),
        const SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: taskItems.length(),
          itemBuilder: (BuildContext context, int index) {
            return TodoItemWidget(task: taskItems.tasks[index]);
          },
        ),
      ],
    );
  }

  Future<void> _removeAllTasksDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Remove all tasks'),
        content: const Text('Are you sure you want to remove all tasks?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              setState(() {
                taskItems.removeAll();
              });
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetAllTasksDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Reset all tasks'),
        content:
            const Text('Are you sure you want to reset progress of all tasks?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              setState(() {
                taskItems.resetAllProgress();
              });
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<void> _addTaskDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter task description',
              ),
              controller: _taskDescriptionController,
            ),
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter number of steps',
              ),
              controller: _taskStepsController,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blueGrey[700])),
            onPressed: () {
              if (_taskDescriptionController.text.isNotEmpty) {
                if (_taskStepsController.text.isNotEmpty &&
                    _taskDescriptionController.text.isNotEmpty) {
                  int? num = int.tryParse(_taskStepsController.text);
                  if (num != null) {
                    taskItems.add(
                        taskDescription: _taskDescriptionController.text,
                        taskSteps: num,
                        onStateChanged: () {
                          setState(() {});
                        });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Add task'),
                        content: const Text(
                            'Adding task failed, steps input must be numeric.'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }
              _taskDescriptionController.text = '';
              _taskStepsController.text = '';
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
