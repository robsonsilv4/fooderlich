import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/friend_post_list_view.dart';

import '../helpers/helpers.dart';

void main() {
  group(FriendPostListView, () {
    testWidgets(
      'renders the header and one tile per post',
      tags: [TestTag.widget],
      (tester) async {
        final posts = List.generate(3, (index) => buildPost());

        await tester.pumpApp(FriendPostListView(friendPosts: posts));

        expect(find.text('Social Chefs 👩‍🍳'), findsOneWidget);
        expect(find.text(posts.first.comment), findsNWidgets(3));
      },
    );

    testWidgets(
      'renders no tiles when there are no posts',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const FriendPostListView(friendPosts: []));

        expect(find.text('Social Chefs 👩‍🍳'), findsOneWidget);
        expect(find.byType(FriendPostListView), findsOneWidget);
      },
    );
  });
}
