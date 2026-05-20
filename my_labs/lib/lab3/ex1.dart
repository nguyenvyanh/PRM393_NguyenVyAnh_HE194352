import 'dart:async';
class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}

class ProductRepository {
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 1200.00),
    Product(id: 2, name: 'Mouse', price: 25.50),
  ];

  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _products;
  }

  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product); 
  }

  void dispose() {
    _controller.close();
  }
}

Future<void> main() async {
  final repo = ProductRepository();

  final products = await repo.getAll();
  print('All products:');
  for (final product in products) {
    print(product);
  }

  final subscription = repo.liveAdded().listen((product) {
    print('Live added: $product');
  });

  repo.addProduct(Product(id: 3, name: 'Keyboard', price: 75.00));
  repo.addProduct(Product(id: 4, name: 'Monitor', price: 300.00));

  await Future.delayed(Duration(milliseconds: 300));

  await subscription.cancel();
  repo.dispose();
}
