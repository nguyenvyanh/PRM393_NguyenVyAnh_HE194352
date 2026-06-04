import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(48, 48),
      painter: LogoPainter(),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width * 0.20, size.height * 0.58);
    path.cubicTo(
      size.width * 0.32,
      size.height * 0.50,
      size.width * 0.42,
      size.height * 0.49,
      size.width * 0.52,
      size.height * 0.40,
    );
    path.cubicTo(
      size.width * 0.62,
      size.height * 0.30,
      size.width * 0.72,
      size.height * 0.24,
      size.width * 0.84,
      size.height * 0.22,
    );
    path.lineTo(size.width * 0.84, size.height * 0.45);
    path.cubicTo(
      size.width * 0.72,
      size.height * 0.48,
      size.width * 0.64,
      size.height * 0.56,
      size.width * 0.54,
      size.height * 0.65,
    );
    path.cubicTo(
      size.width * 0.44,
      size.height * 0.75,
      size.width * 0.32,
      size.height * 0.78,
      size.width * 0.20,
      size.height * 0.82,
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}