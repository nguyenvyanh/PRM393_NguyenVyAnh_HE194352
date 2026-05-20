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
    return 'Product(id: $id, name: $name, price: $price)';
  }
}

class ProductRepository {
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 1200),
    Product(id: 2, name: 'Mouse', price: 25),
    Product(id: 3, name: 'Keyboard', price: 75),
  ];

  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
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

  print('Exercise 1: Product Model & Repository');
  print('Loading all products...');

  final products = await repo.getAll();

  print('All products:');
  for (final product in products) {
    print(product);
  }

  print('\nListening for new products...');

  final subscription = repo.liveAdded().listen((product) {
    print('New product added: $product');
  });

  repo.addProduct(Product(id: 4, name: 'Monitor', price: 300));
  repo.addProduct(Product(id: 5, name: 'Headphone', price: 50));

  await Future.delayed(Duration(milliseconds: 500));

  await subscription.cancel();
  repo.dispose();

}
