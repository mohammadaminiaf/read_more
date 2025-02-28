import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Read More Example')),
        body: Padding(padding: const EdgeInsets.all(16.0), child: SizedBox()),
      ),
    );
  }
}
