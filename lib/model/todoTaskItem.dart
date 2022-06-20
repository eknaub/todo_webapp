import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedIndex.dart';
import 'package:todo_webapp/shared_prefs/prefs.dart';

class TodoTaskItem extends StatefulWidget {
  final int taskIdx;
  final String taskDescription;
  final int taskSteps;
  final int taskCurrentSteps;
  final Function() onRemove; //update state of parent widget

  const TodoTaskItem({
    Key? key,
    required this.taskIdx,
    required this.taskDescription,
    required this.taskSteps,
    required this.taskCurrentSteps,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<TodoTaskItem> createState() => _TodoTaskItemState();
}

class _TodoTaskItemState extends State<TodoTaskItem> {
  late SelectedActivity idx;

  @override
  Widget build(BuildContext context) {
    idx = Provider.of<SelectedActivity>(context);
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => {},
        hoverColor: Colors.blueGrey[700],
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        mouseCursor: MouseCursor.defer,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.blueGrey,
                        color: Colors.green,
                      ),
                    ),
                    Center(
                      child: Text(
                        "0/${widget.taskSteps}",
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              const Spacer(),
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
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Remove activity'),
                    content:
                        const Text('Are you sure you want to remove the task?'),
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
                    sharedPrefs.removeTaskFromActivity(
                        activityIdx: idx.selectedActivityIdx,
                        taskIdx: widget.taskIdx);
                    widget.onRemove();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
