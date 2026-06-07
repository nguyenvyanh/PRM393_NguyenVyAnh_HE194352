import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/budget_item.dart';

class DonutChartPainter extends CustomPainter {
  final List<BudgetItem> items;

  DonutChartPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    final total = items.fold<double>(0, (sum, item) => sum + item.percent);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2.3;
    final strokeWidth = radius * 0.42;

    double startAngle = -math.pi / 2;

    for (final item in items) {
      final sweepAngle = (item.percent / total) * math.pi * 2;

      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return oldDelegate.items != items;
  }
}