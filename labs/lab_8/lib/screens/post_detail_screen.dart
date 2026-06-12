import 'package:flutter/material.dart';

import '../models/post.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài viết #${post.id}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  'User ID: ${post.userId}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Divider(height: 32),
                Text(
                  post.body,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
