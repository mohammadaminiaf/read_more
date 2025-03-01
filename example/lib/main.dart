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
      theme: ThemeData.light().copyWith(),
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
          Constants.mediumText,
          minLines: 3,
          extraBlurLines: 5,
          // style: TextStyle(color: Colors.white),
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
