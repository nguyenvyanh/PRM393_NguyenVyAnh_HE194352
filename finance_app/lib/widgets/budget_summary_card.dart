import 'package:flutter/material.dart';
import '../data/budget_data.dart';
import '../utils/money_formatter.dart';

class BudgetSummaryCard extends StatelessWidget {
  final String selectedProjectType;
  final ValueChanged<String?> onProjectChanged;

  const BudgetSummaryCard({
    super.key,
    required this.selectedProjectType,
    required this.onProjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DỰ TRÙ NGÂN SÁCH',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 22),

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown(),
              const SizedBox(height: 18),

              const Text(
                'Tổng Ngân Sách:',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),

              Text(
                '${formatMoney(2500000000)} VNĐ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 24),

              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xff5bb7b5),
                  inactiveTrackColor: Colors.white24,
                  thumbColor: const Color(0xff5bb7b5),
                ),
                child: Slider(
                  value: 0.35,
                  onChanged: (_) {},
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(child: _buildSmallInput('Ngân Sách')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSmallInput('Tài phí')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff4ca4a6), width: 1.5),
        color: const Color(0xff142324),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedProjectType,
          isExpanded: true,
          dropdownColor: const Color(0xff1a3232),
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: projectTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: onProjectChanged,
        ),
      ),
    );
  }

  Widget _buildSmallInput(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff5bb7b5)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}