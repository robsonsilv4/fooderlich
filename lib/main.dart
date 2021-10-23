import 'package:flutter/material.dart';

void main() {
  runApp(const FooderlishApp());
}

class FooderlishApp extends StatelessWidget {
  const FooderlishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fooderlish',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fooderlish'),
        ),
        body: Container(),
      ),
    );
  }
}
