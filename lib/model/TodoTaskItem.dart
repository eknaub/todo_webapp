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
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
