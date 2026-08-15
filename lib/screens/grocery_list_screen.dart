import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    super.key,
    required this.manager,
  });

  final GroceryManager manager;

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        final item = groceryItems[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 50,
            ),
          ),
          onDismissed: (_) {
            manager.deleteItem(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${item.name} dismissed')),
            );
          },
          child: InkWell(
            onTap: () => manager.groceryItemTapped(index),
            child: GroceryTile(
              key: Key(item.id),
              item: item,
              onComplete: (change) {
                if (change != null) {
                  manager.completeItem(index, change);
                }
              },
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}
