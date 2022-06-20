import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedIndex.dart';
import 'package:todo_webapp/shared_prefs/prefs.dart';
import 'package:todo_webapp/widgets/version.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late TextEditingController _controller;
  late List<String>? activityItems;
  late SelectedActivity activityIdx;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    activityItems = sharedPrefs.getAllActivityNames();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    activityIdx = Provider.of<SelectedActivity>(context);
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
                      if (activityItems != null) {
                        if (activityItems!.contains(_controller.text)) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Add activity'),
                              content: const Text(
                                  'Adding activity failed, activity already exists.'),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () {
                                    Navigator.pop(context, 'Ok');
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          activityItems!.add(_controller.text);
                          sharedPrefs.addActivity(_controller.text);
                        }
                      }
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
            itemCount: activityItems?.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(activityItems![index],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    )),
                trailing: IconButton(
                    onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Remove activity'),
                            content: Text(
                                'Are you sure you want to remove the activity \'${activityItems![index]}\'.'),
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
                            if (activityItems != null) {
                              sharedPrefs.removeActivity(activityItems![index]);
                              activityItems!.remove(activityItems![index]);
                              activityIdx.setSelectedIndex(-1);
                              setState(() {});
                            }
                          }
                        }),
                    icon: const Icon(Icons.delete, color: Colors.white)),
                tileColor: activityIdx.selectedActivityIdx == index
                    ? Colors.blueGrey[800]
                    : null,
                onTap: () {
                  setState(() {
                    activityIdx.setSelectedIndex(index);
                  });
                },
              );
            },
          ),
          const Divider(
            color: Colors.black,
            indent: 16.0,
            endIndent: 16.0,
          ),
          const Center(
            child: Text(
              'Misc',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          ),
          ListTile(
              onTap: () {
                activityIdx.setSelectedIndex(-1);
                setState(() {});
              },
              title: const Text("Notes",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ))),
          const Version()
        ],
      ),
    );
  }
}
