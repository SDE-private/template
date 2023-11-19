import 'package:flutter/material.dart';
import 'package:frontend/tabs/tab_interface.dart';

class HashEverything extends StatefulWidget implements TabInterface {
  final controller = TextEditingController();
  HashEverything({super.key});

  @override
  State<HashEverything> createState() => _HashEverythingState();

  @override
  String get_uri() => "/api/increase-cpu-load";

  @override
  Map<String, String> get_params() => {
    "string": controller.value.text
  };
}

class _HashEverythingState extends State<HashEverything> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Hash everything", style: Theme.of(context).textTheme.headlineLarge),
        Text("Specify a string to hash with pbkdf2", style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 100),
        TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter something to hash',
          ),
        )
      ]
    );
  }
}
