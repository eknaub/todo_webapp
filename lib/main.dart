import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/screens/main_screen.dart';
import 'package:todo_webapp/sharedPrefs/prefs.dart';

Future<void> main() async {
  runApp(const MyApp());
  await sharedPrefs.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedActivity(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
