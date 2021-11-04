import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';

import '../models/models.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceryItemScreen(
                    originalItem: item,
                    onCreate: (_) {},
                    onUpdate: (item) {
                      manager.updateItem(item, index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
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
