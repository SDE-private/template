import 'package:flutter/material.dart';
import 'package:frontend/tabs/wrapper.dart';

import '../tabs/index.dart';

class AssignmentView extends StatefulWidget {
  const AssignmentView({super.key});

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = 0.0;
  final tabs = [
    HashEverything(),
    MemoryLeak()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment"),
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: labelType,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.tag),
                  label: Text('Hash'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.memory),
                  label: Text('Memory'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            TabViewWrapper(to_show: tabs[_selectedIndex])
          ],
        ),
      ),
    );
  }
}