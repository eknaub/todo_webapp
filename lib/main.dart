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
      child: MaterialApp(
        theme: ThemeData(
            backgroundColor: Colors.blueGrey[900],
            primaryColor: Colors.blueGrey[700],
            dividerColor: Colors.blueGrey[900],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueGrey[900],
              shadowColor: Colors.transparent,
            ),
            scaffoldBackgroundColor: Colors.blueGrey[900],
            drawerTheme: DrawerThemeData(
              backgroundColor: Colors.blueGrey[700],
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blueGrey[700]),
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            listTileTheme: const ListTileThemeData(iconColor: Colors.white),
            progressIndicatorTheme: ProgressIndicatorThemeData(
              linearTrackColor: Colors.blueGrey[900],
              color: Colors.blueGrey[700],
            )),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
