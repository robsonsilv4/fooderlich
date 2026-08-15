import 'package:fooderlich/models/models.dart';

class ExploreData {

  ExploreData(
    this.todayRecipes,
    this.friendPosts,
  );
  final List<ExploreRecipe> todayRecipes;
  final List<Post> friendPosts;
}
