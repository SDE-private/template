import 'package:flutter/material.dart';
import 'package:frontend/views/home.dart';

void main() => runApp(const FrontendSDE());

class FrontendSDE extends StatelessWidget {
  const FrontendSDE({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme:  ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
