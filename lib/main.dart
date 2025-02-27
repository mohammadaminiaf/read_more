import 'package:flutter/material.dart';
import 'read_more.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ReadMoreExample(),
        ),
      ),
    );
  }
}

class ReadMoreExample extends StatefulWidget {
  const ReadMoreExample({super.key});

  @override
  State<ReadMoreExample> createState() => _ReadMoreExampleState();
}

class _ReadMoreExampleState extends State<ReadMoreExample> {
  bool isExpanded = false;

  void toggleReadMore() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'This is a long text that will be blurred if it exceeds the minimum lines. '
      'Click the button below to read more or read less.',
    ).blurredReadMore(
      text:
          'This is a long text that will be blurred if it exceeds the minimum lines. '
          'Click the button below to read more or read less.',
      isExpanded: isExpanded,
      onToggle: toggleReadMore,
    );
  }
}
