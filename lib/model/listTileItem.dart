import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  final String name;
  final Function onActivityChanged;

  const ActivityListItem(
      {Key? key, required this.name, required this.onActivityChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          )),
      onTap: () {
        onActivityChanged();
      },
    );
  }
}
