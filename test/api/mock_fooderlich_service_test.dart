import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(MockFooderlichService, () {
    late MockFooderlichService service;

    setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

    setUp(() {
      service = MockFooderlichService();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', null);
    });

    void mockAssetWithJson(String json) {
      rootBundle.clear();
      final bytes = Uint8List.fromList(utf8.encode(json));
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async {
          return ByteData.view(bytes.buffer);
        },
      );
    }

    group('getExploreData', () {
      test(
        'returns today recipes and friend posts',
        tags: [TestTag.unit],
        () async {
          final data = await service.getExploreData();

          expect(data.todayRecipes, isNotEmpty);
          expect(data.friendPosts, isNotEmpty);
          expect(
            data.todayRecipes.first,
            isA<ExploreRecipe>(),
          );
          expect(data.friendPosts.first, isA<Post>());
        },
      );

      test(
        'returns empty lists when assets have no recipes or feed',
        tags: [TestTag.unit],
        () async {
          mockAssetWithJson('{}');

          final data = await service.getExploreData();

          expect(data.todayRecipes, isEmpty);
          expect(data.friendPosts, isEmpty);
        },
      );
    });

    group('getRecipes', () {
      test(
        'returns a list of simple recipes',
        tags: [TestTag.unit],
        () async {
          final recipes = await service.getRecipes();

          expect(recipes, isNotEmpty);
          expect(recipes.first, isA<SimpleRecipe>());
        },
      );

      test(
        'returns an empty list when the asset has no recipes',
        tags: [TestTag.unit],
        () async {
          mockAssetWithJson('{}');

          final recipes = await service.getRecipes();

          expect(recipes, isEmpty);
        },
      );
    });
  });
}
