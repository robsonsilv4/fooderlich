import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/friend_post_tile.dart';

import '../helpers/helpers.dart';

void main() {
  group(FriendPostTile, () {
    testWidgets(
      'renders post comment and timestamp',
      tags: [TestTag.widget],
      (tester) async {
        final post = buildPost();

        await tester.pumpApp(FriendPostTile(post: post));

        expect(find.text(post.comment), findsOneWidget);
        expect(find.text('${post.timestamp} mins ago'), findsOneWidget);
      },
    );
  });
}
