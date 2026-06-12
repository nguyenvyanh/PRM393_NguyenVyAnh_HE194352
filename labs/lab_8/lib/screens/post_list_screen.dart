import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/api_service.dart';
import 'create_post_screen.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  final List<Post> _createdPosts = <Post>[];

  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    _postsFuture = _apiService.fetchPosts();
  }

  Future<void> _refreshPosts() async {
    setState(_loadPosts);
    await _postsFuture;
  }

  Future<void> _openCreateScreen() async {
    final createdPost = await Navigator.of(context).push<Post>(
      MaterialPageRoute<Post>(
        builder: (_) => CreatePostScreen(apiService: _apiService),
      ),
    );

    if (createdPost == null || !mounted) {
      return;
    }

    setState(() {
      _createdPosts.insert(0, createdPost);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã tạo bài viết thành công.'),
      ),
    );
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài viết'),
        actions: [
          IconButton(
            tooltip: 'Tải lại',
            onPressed: () {
              setState(_loadPosts);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _LoadingView();
          }

          if (snapshot.hasError) {
            return _ErrorView(
              message: snapshot.error.toString(),
              onRetry: () {
                setState(_loadPosts);
              },
            );
          }

          final posts = <Post>[
            ..._createdPosts,
            ...?snapshot.data,
          ];

          if (posts.isEmpty) {
            return const Center(
              child: Text('Không có bài viết nào.'),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshPosts,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(post.id.toString()),
                    ),
                    title: Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      post.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PostDetailScreen(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateScreen,
        icon: const Icon(Icons.add),
        label: const Text('Tạo mới'),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Đang tải dữ liệu...'),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Không thể tải dữ liệu',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}
