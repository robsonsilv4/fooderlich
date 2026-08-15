import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/screens.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.currentTab, super.key,
  });

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
  State<HomeScreen> createState() => _HomeScreenState();
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          _profileButton(),
        ],
      ),
      body: Consumer<AppStateManager>(
        builder: (context, appStateManager, child) {
          return IndexedStack(
            index: widget.currentTab,
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: widget.currentTab,
        onTap: (index) => context.read<AppStateManager>().goToTab(index),
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
        onTap: () => context.read<ProfileManager>().tapOnProfile(true),
      ),
    );
  }
}
