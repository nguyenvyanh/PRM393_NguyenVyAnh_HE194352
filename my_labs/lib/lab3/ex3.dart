import 'dart:async';


void main() {

  print('1. Start main');

  scheduleMicrotask(() {
    print('3. Microtask runs before Future event');
  });

  Future(() {
    print('4. Future event callback');
  });

  print('2. End main');

}
