import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(const FooderlishApp());
}

class FooderlishApp extends StatelessWidget {
  const FooderlishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();

    return MaterialApp(
      title: 'Fooderlish',
      theme: theme,
      home: const Home(),
    );
  }
}
