import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static MaterialPage page() => MaterialPage(
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
    context.read<AppStateManager>().initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
