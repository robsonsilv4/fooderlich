import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'models/models.dart';
import 'screens/screens.dart';

void main() {
  runApp(const FooderlishApp());
}

class FooderlishApp extends StatefulWidget {
  const FooderlishApp({Key? key}) : super(key: key);

  @override
  State<FooderlishApp> createState() => _FooderlishAppState();
}

class _FooderlishAppState extends State<FooderlishApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileManager()),
        ChangeNotifierProvider(create: (_) => GroceryManager()),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            title: 'Fooderlich',
            theme: theme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
