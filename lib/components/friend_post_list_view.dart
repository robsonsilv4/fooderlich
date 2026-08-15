import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({
    required this.friendPosts, super.key,
  });

  final List<Post> friendPosts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            itemCount: friendPosts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final post = friendPosts[index];
              return FriendPostTile(post: post);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
