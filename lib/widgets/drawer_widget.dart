import 'package:flutter/material.dart';

import '../model/listTileItem.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late TextEditingController _controller;
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    items.add(ActivityListItem(
      name: 'Game',
      onActivityChanged: () {},
    ));
    items.add(ActivityListItem(
      name: 'Sport',
      onActivityChanged: () {},
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey[700],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              Center(
                child: IconButton(
                  iconSize: 50.0,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Add activity'),
                      content: TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter a new activity',
                        ),
                        controller: _controller,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, ''),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blueGrey[700])),
                          onPressed: () {
                            Navigator.pop(context, _controller.text);
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value != null && value.isNotEmpty) {
                      items.add(ActivityListItem(
                        name: _controller.text,
                        onActivityChanged: () {},
                      ));
                    }
                    _controller.text = '';
                    setState(() {});
                  }),
                ),
              ),
              const Text(
                'Add new activity',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.black,
            indent: 16.0,
            endIndent: 16.0,
          ),
          const Center(
            child: Text(
              'Activities',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
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
          const Divider(
            color: Colors.black,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Version 0.01",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
