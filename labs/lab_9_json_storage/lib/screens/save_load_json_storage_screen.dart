import 'package:flutter/material.dart';

import '../models/storage_item.dart';
import '../repositories/json_file_repository.dart';

class SaveLoadJsonStorageScreen extends StatefulWidget {
  const SaveLoadJsonStorageScreen({super.key});

  @override
  State<SaveLoadJsonStorageScreen> createState() =>
      _SaveLoadJsonStorageScreenState();
}

class _SaveLoadJsonStorageScreenState extends State<SaveLoadJsonStorageScreen> {
  final JsonFileRepository _repository = const JsonFileRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<StorageItem> _items = [];
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _repository.loadStorageItems();

    if (!mounted) return;
    setState(() {
      _items = items;
      _isLoading = false;
    });
  }

  Future<void> _saveItems() async {
    setState(() => _isSaving = true);

    try {
      await _repository.saveStorageItems(_items);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved JSON to local storage')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _addItem() {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();

    if (title.isEmpty || note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter title and note')),
      );
      return;
    }

    final newId = _items.isEmpty
        ? 1
        : _items.map((item) => item.id).reduce((a, b) => a > b ? a : b) + 1;

    setState(() {
      _items.add(
        StorageItem(
          id: newId,
          title: title,
          note: note,
        ),
      );
    });

    _titleController.clear();
    _noteController.clear();
  }

  Future<void> _reloadFromStorage() async {
    setState(() => _isLoading = true);
    await _loadItems();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reloaded JSON from device storage')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        if (_isSaving) const LinearProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Item title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Item note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add),
                          label: const Text('Add item'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isSaving ? null : _saveItems,
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: _reloadFromStorage,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reload from storage'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: _items.isEmpty
              ? const Center(
                  child: Text('No items yet. Add data and press Save.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(item.id.toString()),
                        ),
                        title: Text(item.title),
                        subtitle: Text(item.note),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
