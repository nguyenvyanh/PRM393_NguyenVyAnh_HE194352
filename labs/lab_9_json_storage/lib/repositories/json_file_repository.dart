import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/product.dart';
import '../models/storage_item.dart';

class JsonFileRepository {
  const JsonFileRepository();

  static const String itemsFileName = 'lab_9_2_items.json';
  static const String productsFileName = 'lab_9_3_products_db.json';
  static const String productsSeedAsset = 'assets/data/products_seed.json';

  Future<File> _localFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  Future<List<StorageItem>> loadStorageItems() async {
    final file = await _localFile(itemsFileName);

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode([]));
    }

    final jsonString = await file.readAsString();
    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    return jsonList
        .map((json) => StorageItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveStorageItems(List<StorageItem> items) async {
    final file = await _localFile(itemsFileName);
    final jsonList = items.map((item) => item.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList), flush: true);
  }

  Future<List<Product>> loadProducts() async {
    final file = await _localFile(productsFileName);

    if (!await file.exists()) {
      final seedString = await rootBundle.loadString(productsSeedAsset);
      await file.writeAsString(seedString, flush: true);
    }

    final jsonString = await file.readAsString();
    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    return jsonList
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveProducts(List<Product> products) async {
    final file = await _localFile(productsFileName);
    final jsonList = products.map((product) => product.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList), flush: true);
  }

  Future<List<Product>> resetProductsFromSeed() async {
    final seedString = await rootBundle.loadString(productsSeedAsset);
    final jsonList = jsonDecode(seedString) as List<dynamic>;
    final products = jsonList
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();

    await saveProducts(products);
    return products;
  }
}
