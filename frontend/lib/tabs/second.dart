import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/tabs/tab_interface.dart';

class MemoryLeak extends StatefulWidget implements TabInterface {
  final controller = TextEditingController();
  MemoryLeak({super.key});

  @override
  State<MemoryLeak> createState() => _MemoryLeakState();

  @override
  String get_uri() => "memory-leak";

  @override
  Map<String, String> get_params() => {
    "side": controller.value.text
  };
}

class _MemoryLeakState extends State<MemoryLeak> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Random matrix", style: Theme.of(context).textTheme.headlineLarge),
          Text("Enter the length of the side of the square matrix", style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 100),
          TextField(
            controller: widget.controller,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the side',
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ]
          )
        ]
    );
  }
}
