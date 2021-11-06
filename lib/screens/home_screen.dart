import 'package:flutter/material.dart';

import '../models/models.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FooderlichPages.homePath,
      key: ValueKey(FooderlichPages.homePath),
      child: HomeScreen(
        currentTab: currentTab,
      ),
    );
  }

  final int currentTab;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<Widget> _pages = [
    const ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlish',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          _profileButton(),
        ],
      ),
      body: IndexedStack(
        index: widget.currentTab,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: widget.currentTab,
        onTap: (index) => {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To buy',
          ),
        ],
      ),
    );
  }

  Widget _profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
