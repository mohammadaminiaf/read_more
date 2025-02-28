import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:readmore_flutter/readmore_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadMore Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReadMore Flutter Demo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlurredReadMore(
          minLines: 3,
          text: Constants.longText,
          onHashtagTap: (p0) {
            print('Hashtag tapped: $p0');
          },
          onUrlTap: (p0) {
            print('URL tapped: $p0');
          },
        ),
      ),
    );
  }
}
