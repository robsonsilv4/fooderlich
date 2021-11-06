import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'models/models.dart';
import 'navigation/navigation.dart';

void main() {
  runApp(const FooderlishApp());
}

class FooderlishApp extends StatefulWidget {
  const FooderlishApp({Key? key}) : super(key: key);

  @override
  State<FooderlishApp> createState() => _FooderlishAppState();
}

class _FooderlishAppState extends State<FooderlishApp> {
  late AppRouter _appRouter;

  final _appStateManager = AppStateManager();
  final _profileManager = ProfileManager();
  final _groceryManager = GroceryManager();

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      profileManager: _profileManager,
      groceryManager: _groceryManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _appStateManager),
        ChangeNotifierProvider(create: (_) => _profileManager),
        ChangeNotifierProvider(create: (_) => _groceryManager),
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
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
