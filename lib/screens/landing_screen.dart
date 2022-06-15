import 'package:flutter/material.dart';
import 'package:todo_webapp/responsive.dart';

import '../widgets/drawer_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Text(
                          "All tasks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          label: const Text(
                            "New task",
                          ),
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          icon: const Icon(Icons.refresh),
                          label: const Text(
                            "Reset all",
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(6.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                        Column(
                          children: const [
                            CircularProgressIndicator(
                              value: 0.7,
                              backgroundColor: Colors.blueGrey,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "4/5",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                        const Spacer(),
                        const Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Tags",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(Icons.delete, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
