import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selected_activity.dart';
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
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey.shade600),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueGrey[900],
            shadowColor: Colors.transparent,
          ),
          scaffoldBackgroundColor: Colors.blueGrey[900],
          drawerTheme: DrawerThemeData(
            backgroundColor: Colors.blueGrey[700],
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.blueGrey[900],
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey[700]),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          listTileTheme: const ListTileThemeData(iconColor: Colors.white),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            linearTrackColor: Colors.blueGrey[900],
            color: Colors.blueGrey[700],
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodySmall: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
