import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(Post, () {
    group('fromJson', () {
      test(
        'returns a $Post with values from json',
        tags: [TestTag.unit],
        () {
          final post = Post.fromJson(const <String, dynamic>{
            'id': '1',
            'profileImageUrl': 'assets/profile_pics/person_ray.jpeg',
            'comment': 'Great bread!',
            'foodPictureUrl': 'assets/food_pics/bread.png',
            'timestamp': '2h',
          });

          expect(post.id, equals('1'));
          expect(
            post.profileImageUrl,
            equals('assets/profile_pics/person_ray.jpeg'),
          );
          expect(post.comment, equals('Great bread!'));
          expect(post.foodPictureUrl, equals('assets/food_pics/bread.png'));
          expect(post.timestamp, equals('2h'));
        },
      );

      test(
        'returns empty strings when keys are missing',
        tags: [TestTag.unit],
        () {
          final post = Post.fromJson(const <String, dynamic>{});

          expect(post.id, isEmpty);
          expect(post.profileImageUrl, isEmpty);
          expect(post.comment, isEmpty);
          expect(post.foodPictureUrl, isEmpty);
          expect(post.timestamp, isEmpty);
        },
      );
    });
  });
}
