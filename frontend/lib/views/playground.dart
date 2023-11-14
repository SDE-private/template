import 'package:flutter/material.dart';
import 'package:frontend/tabs/wrapper.dart';

import '../tabs/index.dart';

class PlaygroundView extends StatefulWidget {
  const PlaygroundView({super.key});

  @override
  State<PlaygroundView> createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = 0.0;
  final tabs = [
    HashEverything(),
    SecondTab(),
    ThirdTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web server playground"),
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
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('Hash'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
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