import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/screens.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  Widget _buildGroceryScreen() {
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListScreen(manager: manager);
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGroceryScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<GroceryManager>().createNewItem(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
