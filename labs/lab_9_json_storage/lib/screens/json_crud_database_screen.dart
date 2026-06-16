import 'package:flutter/material.dart';

import '../models/product.dart';
import '../repositories/json_file_repository.dart';

class ProductFormData {
  final String name;
  final String category;
  final int price;

  const ProductFormData({
    required this.name,
    required this.category,
    required this.price,
  });
}

class JsonCrudDatabaseScreen extends StatefulWidget {
  const JsonCrudDatabaseScreen({super.key});

  @override
  State<JsonCrudDatabaseScreen> createState() => _JsonCrudDatabaseScreenState();
}

class _JsonCrudDatabaseScreenState extends State<JsonCrudDatabaseScreen> {
  final JsonFileRepository _repository = const JsonFileRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Product> _products = [];
  String _keyword = '';
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _repository.loadProducts();

    if (!mounted) return;
    setState(() {
      _products = products;
      _isLoading = false;
    });
  }

  List<Product> get _filteredProducts {
    if (_keyword.trim().isEmpty) {
      return _products;
    }

    final search = _keyword.toLowerCase();

    return _products.where((product) {
      return product.name.toLowerCase().contains(search) ||
          product.category.toLowerCase().contains(search) ||
          product.price.toString().contains(search);
    }).toList();
  }

  int _generateNewId(List<Product> products) {
    if (products.isEmpty) return 1;
    return products.map((product) => product.id).reduce(
              (a, b) => a > b ? a : b,
            ) +
        1;
  }

  Future<void> _saveProductChanges(
    List<Product> nextProducts,
    String successMessage,
  ) async {
    if (_isSaving) return;

    final previousProducts = List<Product>.of(_products);

    setState(() {
      _products = nextProducts;
      _isSaving = true;
    });

    try {
      await _repository.saveProducts(nextProducts);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(successMessage)),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => _products = previousProducts);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save product database')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _showProductDialog({Product? product}) async {
    final isEditing = product != null;
    final formData = await showDialog<ProductFormData>(
      context: context,
      builder: (dialogContext) {
        return _ProductDialog(product: product);
      },
    );

    if (formData == null) return;

    if (isEditing) {
      final editingProduct = product;

      final nextProducts = _products.map((item) {
        if (item.id != editingProduct.id) return item;
        return item.copyWith(
          name: formData.name,
          category: formData.category,
          price: formData.price,
        );
      }).toList();

      await _saveProductChanges(nextProducts, 'Product updated and saved');
      return;
    }

    final nextProducts = [
      ..._products,
      Product(
        id: _generateNewId(_products),
        name: formData.name,
        category: formData.category,
        price: formData.price,
      ),
    ];

    await _saveProductChanges(nextProducts, 'Product added and saved');
  }

  Future<void> _deleteProduct(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirm delete'),
          content: Text('Delete "${product.name}" from local JSON database?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    final nextProducts =
        _products.where((item) => item.id != product.id).toList();
    await _saveProductChanges(nextProducts, 'Product deleted and saved');
  }

  Future<void> _resetDatabase() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      final products = await _repository.resetProductsFromSeed();

      if (!mounted) return;
      setState(() {
        _products = products;
        _keyword = '';
        _searchController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Database reset from seed JSON')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = _filteredProducts;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Column(
          children: [
            if (_isSaving) const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search by name, category or price',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _keyword.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _keyword = '';
                              _searchController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() => _keyword = value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    '${visibleProducts.length} product(s)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _isSaving ? null : _resetDatabase,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset DB'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: visibleProducts.isEmpty
                  ? const Center(child: Text('No matching products found.'))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                      itemCount: visibleProducts.length,
                      itemBuilder: (context, index) {
                        final product = visibleProducts[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(product.id.toString()),
                            ),
                            title: Text(
                              product.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Category: ${product.category}\n'
                              'Price: ${product.price} VND',
                            ),
                            isThreeLine: true,
                            trailing: Wrap(
                              spacing: 4,
                              children: [
                                IconButton(
                                  tooltip: 'Edit',
                                  icon: const Icon(Icons.edit),
                                  onPressed: _isSaving
                                      ? null
                                      : () {
                                          _showProductDialog(product: product);
                                        },
                                ),
                                IconButton(
                                  tooltip: 'Delete',
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: _isSaving
                                      ? null
                                      : () {
                                          _deleteProduct(product);
                                        },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            onPressed: _isSaving ? null : () => _showProductDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ),
      ],
    );
  }
}

class _ProductDialog extends StatefulWidget {
  final Product? product;

  const _ProductDialog({this.product});

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  late final TextEditingController _priceController;
  String? _errorText;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _categoryController = TextEditingController(text: product?.category ?? '');
    _priceController = TextEditingController(
      text: product?.price.toString() ?? '',
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final price = int.tryParse(_priceController.text.trim());

    if (name.isEmpty || category.isEmpty || price == null) {
      setState(() {
        _errorText = 'Please enter valid product information';
      });
      return;
    }

    Navigator.pop(
      context,
      ProductFormData(
        name: name,
        category: category,
        price: price,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit product' : 'Add product'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_errorText != null) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(_isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
