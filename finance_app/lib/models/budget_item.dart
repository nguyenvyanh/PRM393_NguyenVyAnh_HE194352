  import 'package:flutter/material.dart';

class BudgetItem {
  final String title;
  final double amount;
  final String status;
  final double percent;
  final IconData icon;
  final Color color;

  const BudgetItem({
    required this.title,
    required this.amount,
    required this.status,
    required this.percent,
    required this.icon,
    required this.color,
  });
}