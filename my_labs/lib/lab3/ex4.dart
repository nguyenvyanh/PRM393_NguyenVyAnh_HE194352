Future<void> main() async {

  final Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  final Stream<int> transformed = numbers
      .map((number) => number * number)
      .where((square) => square.isEven);

  print('Even squares:');

  await for (final value in transformed) {
    print(value);
  }

}
