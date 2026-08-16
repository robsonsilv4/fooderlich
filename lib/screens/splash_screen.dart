import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static MaterialPage<void> page() => MaterialPage(
        name: FooderlichPages.splashPath,
        key: ValueKey(FooderlichPages.splashPath),
        child: const SplashScreen(),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(context.read<AppStateManager>().initializeApp());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 120,
              color: Color.fromRGBO(64, 143, 77, 1),
            ),
            SizedBox(height: 16),
            Text('Fooderlich', style: TextStyle(fontSize: 32)),
            SizedBox(height: 8),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
