import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

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
                  onPressed: () {},
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
          ListTile(
            title: const Text('Game',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Sport',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
            onTap: () {
              // Update the state of the app.
              // ...
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
