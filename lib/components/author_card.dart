import 'package:flutter/material.dart';
import 'package:fooderlich/components/circle_image.dart';

class AuthorCard extends StatefulWidget {
  const AuthorCard({
    required this.authorName,
    required this.title,
    super.key,
    this.imageProvider,
  });

  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleImage(
                  imageRadius: 28,
                  imageProvider: widget.imageProvider,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.authorName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
            ),
            iconSize: 30,
            color: Colors.red[400],
            onPressed: () => setState(
              () => _isFavorited = !_isFavorited,
            ),
          ),
        ],
      ),
    );
  }
}
