import 'package:flutter/material.dart';
import 'package:frontend/views/home.dart';

void main() => runApp(const FrontendSDE());

class FrontendSDE extends StatelessWidget {
  const FrontendSDE({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
