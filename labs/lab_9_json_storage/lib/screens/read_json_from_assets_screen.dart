import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadJsonFromAssetsScreen extends StatefulWidget {
  const ReadJsonFromAssetsScreen({super.key});

  @override
  State<ReadJsonFromAssetsScreen> createState() =>
      _ReadJsonFromAssetsScreenState();
}

class _ReadJsonFromAssetsScreenState extends State<ReadJsonFromAssetsScreen> {
  List<dynamic> _students = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentsFromAssets();
  }

  Future<void> _loadStudentsFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/data/students.json');
    final decodedData = jsonDecode(jsonString) as List<dynamic>;

    if (!mounted) return;
    setState(() {
      _students = decodedData;
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await _loadStudentsFromAssets();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reloaded JSON from assets')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final item = _students[index] as Map<String, dynamic>;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(item['id'].toString()),
              ),
              title: Text(
                item['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Major: ${item['major']}\nScore: ${item['score']}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
