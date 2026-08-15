import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    AppStateManager? appStateManager,
    ProfileManager? profileManager,
    GroceryManager? groceryManager,
  }) {
    GoogleFonts.config.allowRuntimeFetching = false;
    return pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => appStateManager ?? AppStateManager(),
          ),
          ChangeNotifierProvider(
            create: (_) => profileManager ?? ProfileManager(),
          ),
          ChangeNotifierProvider(
            create: (_) => groceryManager ?? GroceryManager(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(body: widget),
        ),
      ),
    );
  }
}
