import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/models.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _mockFooderlichService = MockFooderlichService();

  ScrollController? _scrollController;

  void _scrollListener() {
    final controller = _scrollController;

    if (controller != null) {
      final maxScroll =
          controller.offset >= controller.position.maxScrollExtent;
      final minScroll =
          controller.offset <= controller.position.minScrollExtent;
      final outOfRange = controller.position.outOfRange;

      if (maxScroll && !outOfRange) {
        debugPrint('I\'m at the bottom');
      }

      if (minScroll && !outOfRange) {
        debugPrint('I\'m at the top');
      }
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExploreData>(
      future: _mockFooderlichService.getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          final friendPosts = snapshot.data?.friendPosts ?? [];
          return ListView(
            controller: _scrollController,
            children: [
              TodayRecipeListView(recipes: recipes),
              const SizedBox(height: 16),
              FriendPostListView(friendPosts: friendPosts),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
