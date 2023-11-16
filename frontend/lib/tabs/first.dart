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
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Enter something to hash',
      ),
    );
  }
}
