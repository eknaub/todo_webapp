import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/activityList.dart';
import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/widgets/version_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late TextEditingController _activityController;
  late ActivityList activityList;
  late SelectedActivity activityIdx;

  @override
  void initState() {
    super.initState();
    _activityController = TextEditingController();
    activityList = ActivityList();
  }

  @override
  void dispose() {
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    activityIdx = Provider.of<SelectedActivity>(context);
    return Drawer(
      width: 250.0,
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
                  ),
                  onPressed: () => _addActivityDialog(context),
                ),
              ),
              Text(
                'Add new activity',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          const Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
          Center(
            child: Text('Activities',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: activityList.length(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                ),
                title: Text(activityList.getActivityAt(index: index),
                    style: Theme.of(context).textTheme.titleMedium),
                trailing: IconButton(
                    onPressed: () => _removeActivityDialog(context, index),
                    icon: const Icon(
                      Icons.delete,
                    )),
                tileColor: activityIdx.selectedActivityIdx == index
                    ? Theme.of(context).backgroundColor
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
            indent: 16.0,
            endIndent: 16.0,
          ),
          Center(
            child: Text(
              'Misc',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
            tileColor: activityIdx.selectedActivityIdx == -1
                ? Theme.of(context).backgroundColor
                : null,
            onTap: () {
              setState(() {
                activityIdx.setSelectedIndex(-1);
              });
            },
            title:
                Text("Notes", style: Theme.of(context).textTheme.titleMedium),
          ),
          const Version()
        ],
      ),
    );
  }

  Future<void> _removeActivityDialog(BuildContext context, int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Remove activity'),
        content: Text(
            'Are you sure you want to remove the activity \'${activityList.getActivityAt(index: index)}\'.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () {
              setState(() {
                activityList.removeAt(index: index);
                activityIdx.setSelectedIndex(-1);
                Navigator.pop(context);
              });
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Future<void> _addActivityDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add activity'),
        content: TextField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Enter a new activity',
          ),
          controller: _activityController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              _activityController.text = '',
              Navigator.pop(context),
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_activityController.text.isNotEmpty) {
                if (activityList.contains(activity: _activityController.text)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Add activity'),
                      content: const Text(
                          'Activity already exists, enter a new one.'),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                } else {
                  activityList.add(activity: _activityController.text);
                  _activityController.text = '';
                  Navigator.pop(context);
                }
              }
              setState(() {});
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
