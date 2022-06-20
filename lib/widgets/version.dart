import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  static const String version = "0.1";
  const Version({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text("Version $version",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
