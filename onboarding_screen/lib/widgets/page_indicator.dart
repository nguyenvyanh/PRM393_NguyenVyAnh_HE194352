import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final bool isActive = currentIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 10 : 7,
            height: isActive ? 10 : 7,
            decoration: BoxDecoration(
              color: isActive ? Colors.black : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}