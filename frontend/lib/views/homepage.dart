import 'package:flutter/material.dart';
import 'package:frontend/views/exercises.dart';
import 'package:frontend/views/assignment.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web Service Monitoring Playground"),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              make_button("Exercises", Icons.videogame_asset_rounded, go_to_examples),
              make_button("Assignment", Icons.assignment, go_to_exercises)
            ],
          ),
        )
      ),
    );
  }

  void go_to_examples() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ExercisesView())
    );
  }

  void go_to_exercises() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AssignmentView())
    );
  }

  Widget make_button(String text, IconData icon, void Function() callback) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: double.infinity,
          child: ElevatedButton(
            onPressed: callback,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 200),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
