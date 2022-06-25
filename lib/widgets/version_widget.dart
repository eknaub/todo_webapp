import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  static const String version = "1.1";
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
          child: Text("Version $version",
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
