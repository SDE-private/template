import 'package:flutter/material.dart';
import 'package:frontend/tabs/tab_interface.dart';

class MemoryLeak extends StatefulWidget implements TabInterface {
  final controller = TextEditingController();
  MemoryLeak({super.key});

  @override
  State<MemoryLeak> createState() => _MemoryLeakState();

  @override
  String get_uri() => "memory-leak";

  @override
  Map<String, String> get_params() => {};
}

class _MemoryLeakState extends State<MemoryLeak> {
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
