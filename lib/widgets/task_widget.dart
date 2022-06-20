import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedIndex.dart';
import 'package:todo_webapp/model/todoTaskItem.dart';
import 'package:todo_webapp/shared_prefs/prefs.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController _taskDescriptionController;
  late TextEditingController _taskStepsController;
  late SelectedActivity activityIdx;
  List<Widget> items = [];
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _taskDescriptionController = TextEditingController();
    _taskStepsController = TextEditingController();
  }

  @override
  void dispose() {
    _taskDescriptionController.dispose();
    _taskStepsController.dispose();
    super.dispose();
  }

  void _buildItems() {
    items.clear();
    for (var task in data) {
      items.add(TodoTaskItem(
          taskIdx: task[0],
          taskSteps: task[1],
          taskCurrentSteps: task[1],
          taskDescription: task[3],
          onRemove: () {
            setState(() {});
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    activityIdx = Provider.of<SelectedActivity>(context);
    data = sharedPrefs.getTasksForActivity(activityIdx.selectedActivityIdx);
    _buildItems();
    return Column(
      children: [
        Row(
          children: [
            Text(
              sharedPrefs
                  .getCurrentActivityName(activityIdx.selectedActivityIdx),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 25.0,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              label: const Text(
                "New task",
              ),
              icon: const Icon(Icons.add),
              onPressed: () => showDialog<String>(
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
                      onPressed: () => Navigator.pop(context, ''),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey[700])),
                      onPressed: () {
                        Navigator.pop(context, _taskDescriptionController.text);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ).then(
                (value) {
                  if (value != null && value.isNotEmpty) {
                    if (_taskStepsController.text.isNotEmpty &&
                        _taskDescriptionController.text.isNotEmpty) {
                      int? num = int.tryParse(_taskStepsController.text);
                      if (num != null) {
                        items.add(TodoTaskItem(
                            taskIdx: data.length,
                            taskDescription: _taskDescriptionController.text,
                            taskSteps: num,
                            taskCurrentSteps: num,
                            onRemove: () {
                              setState(() {});
                            }));
                        sharedPrefs.addTaskToActivity(
                            taskIdx: data.length,
                            activityIdx: activityIdx.selectedActivityIdx,
                            description: _taskDescriptionController.text,
                            steps: num,
                            currSteps: num);
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
                                  Navigator.pop(context, 'Ok');
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
                },
              ),
            ),
            const SizedBox(
              width: 25.0,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              icon: const Icon(Icons.refresh),
              label: const Text(
                "Reset all tasks",
              ),
            ),
            const SizedBox(
              width: 25.0,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              icon: const Icon(Icons.delete),
              label: const Text(
                "Remove all tasks",
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Remove all tasks'),
                  content:
                      const Text('Are you sure you want to remove all tasks?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, ''),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        Navigator.pop(context, 'Remove');
                      },
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ).then((value) {
                if (value == 'Remove') {
                  sharedPrefs.removeAllTasksFromActivity(
                      activityIdx: activityIdx.selectedActivityIdx);
                  setState(() {});
                }
              }),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: items[index],
            );
          },
        ),
      ],
    );
  }
}
