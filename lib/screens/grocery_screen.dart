import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'screens.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

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
        onPressed: () {
          final manager = context.read<GroceryManager>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (_) {},
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
