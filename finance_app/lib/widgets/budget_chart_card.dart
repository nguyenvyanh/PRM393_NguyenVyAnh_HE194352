import 'package:flutter/material.dart';
import '../models/budget_item.dart';
import 'donut_chart_painter.dart';

class BudgetChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<BudgetItem> items;
  final String totalText;

  const BudgetChartCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    this.totalText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xff1c292b),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(80),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 190,
                child: CustomPaint(
                  painter: DonutChartPainter(items),
                  child: Center(
                    child: Container(
                      width: 78,
                      height: 78,
                      decoration: const BoxDecoration(
                        color: Color(0xff1c292b),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: items.map((item) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: item.color,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${item.title}: ${item.percent.toInt()}%',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),

              if (totalText.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  totalText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}