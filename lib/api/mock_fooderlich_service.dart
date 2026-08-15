import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:fooderlich/models/models.dart';

class MockFooderlichService {
  Future<ExploreData> getExploreData() async {
    final todayRecipes = await _getTodayRecipes();
    final friendPosts = await _getFriendFeed();

    return ExploreData(todayRecipes, friendPosts);
  }

  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadAsset(
      'assets/sample_data/sample_explore_recipes.json',
    );

    final json = jsonDecode(dataString) as Map<String, dynamic>;

    final jsonRecipes = json['recipes'] as List<dynamic>?;
    if (jsonRecipes != null) {
      final recipes = <ExploreRecipe>[];
      for (final value in jsonRecipes) {
        recipes.add(
          ExploreRecipe.fromJson(value as Map<String, dynamic>),
        );
      }
      return recipes;
    } else {
      return [];
    }
  }

  Future<List<Post>> _getFriendFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadAsset(
      'assets/sample_data/sample_friends_feed.json',
    );

    final json = jsonDecode(dataString) as Map<String, dynamic>;

    final jsonFeed = json['feed'] as List<dynamic>?;
    if (jsonFeed != null) {
      final posts = <Post>[];
      for (final value in jsonFeed) {
        posts.add(Post.fromJson(value as Map<String, dynamic>));
      }
      return posts;
    } else {
      return [];
    }
  }

  Future<List<SimpleRecipe>> getRecipes() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadAsset(
      'assets/sample_data/sample_recipes.json',
    );

    final json = jsonDecode(dataString) as Map<String, dynamic>;

    final jsonRecipes = json['recipes'] as List<dynamic>?;
    if (jsonRecipes != null) {
      final recipes = <SimpleRecipe>[];
      for (final value in jsonRecipes) {
        recipes.add(
          SimpleRecipe.fromJson(value as Map<String, dynamic>),
        );
      }
      return recipes;
    } else {
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
