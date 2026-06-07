import 'package:flutter/material.dart';
import '../models/budget_item.dart';
import '../utils/money_formatter.dart';

class BudgetItemCard extends StatelessWidget {
  final BudgetItem item;

  const BudgetItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xff1c292b),
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: item.color, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(70),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(item.icon, color: item.color, size: 34),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Estimated ${formatMoney(item.amount)}đ',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                Text(
                  item.status,
                  style: TextStyle(
                    color: Colors.green.shade300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.more_vert, color: Colors.white70),
        ],
      ),
    );
  }
}