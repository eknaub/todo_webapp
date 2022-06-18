import 'package:flutter/material.dart';

class TodoTaskItem extends StatefulWidget {
  final String taskDescription;
  final int taskSteps;
  final Function onTaskChanged;
  const TodoTaskItem(
      {Key? key,
      required this.taskDescription,
      required this.taskSteps,
      required this.onTaskChanged})
      : super(key: key);

  @override
  State<TodoTaskItem> createState() => _TodoTaskItemState();
}

class _TodoTaskItemState extends State<TodoTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
              Column(
                children: [
                  const CircularProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.blueGrey,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "0/${widget.taskSteps}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  )
                ],
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
              const Text(
                "Tags",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
