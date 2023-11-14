import 'package:flutter/material.dart';
import 'package:frontend/singletons/recurrent_calls.dart';
import 'package:frontend/views/homepage.dart';

void main() => runApp(const FrontendSDE());

class FrontendSDE extends StatelessWidget {
  const FrontendSDE({super.key});

  @override
  Widget build(BuildContext context) {
    RecurrentCalls.init();
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme:  ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const HomepageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
