import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/navigation/navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FooderlishApp());
}

class FooderlishApp extends StatefulWidget {
  const FooderlishApp({super.key});

  @override
  State<FooderlishApp> createState() => _FooderlishAppState();
}

class _FooderlishAppState extends State<FooderlishApp> {
  late AppRouter _appRouter;
  final _routeParser = AppRouteParser();
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

          return MaterialApp.router(
            title: 'Fooderlich',
            theme: theme,
            routerDelegate: _appRouter,
            routeInformationParser: _routeParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          );
        },
      ),
    );
  }
}
