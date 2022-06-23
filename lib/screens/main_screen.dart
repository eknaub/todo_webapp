import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_webapp/model/selectedActivity.dart';
import 'package:todo_webapp/responsive.dart';
import 'package:todo_webapp/widgets/drawer_widget.dart';
import 'package:todo_webapp/widgets/notes_widget.dart';
import 'package:todo_webapp/widgets/task_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late SelectedActivity idx;

  @override
  Widget build(BuildContext context) {
    idx = Provider.of<SelectedActivity>(context);
    return Scaffold(
        drawer:
            Responsive.isMobile(context) ? const DrawerWidget() : Container(),
        appBar: Responsive.isMobile(context)
            ? AppBar(
                backgroundColor: Colors.blueGrey[900],
                shadowColor: Colors.transparent,
              )
            : null,
        backgroundColor: Colors.blueGrey[900],
        body: Row(
          children: [
            Responsive.isDesktop(context) ? const DrawerWidget() : Container(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: idx.selectedActivityIdx == -1
                    ? const NotesWidget()
                    : const TaskWidget(),
              ),
            ),
          ],
        ));
  }
}
