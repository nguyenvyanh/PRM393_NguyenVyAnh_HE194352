import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    super.key,
    required this.apiService,
  });

  final ApiService apiService;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final Post createdPost = await widget.apiService.createPost(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(createdPost);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo bài viết'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề',
                    hintText: 'Nhập tiêu đề bài viết',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tiêu đề.';
                    }
                    if (value.trim().length < 3) {
                      return 'Tiêu đề phải có ít nhất 3 ký tự.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung',
                    hintText: 'Nhập nội dung bài viết',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.notes),
                    alignLabelWithHint: true,
                  ),
                  minLines: 5,
                  maxLines: 8,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập nội dung.';
                    }
                    if (value.trim().length < 5) {
                      return 'Nội dung phải có ít nhất 5 ký tự.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(
                    _isSubmitting ? 'Đang gửi...' : 'Gửi bài viết',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
