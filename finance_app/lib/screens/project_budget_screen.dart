import 'package:flutter/material.dart';

import '../data/budget_data.dart';
import '../utils/money_formatter.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/budget_chart_card.dart';
import '../widgets/budget_item_card.dart';
import '../widgets/budget_summary_card.dart';

class ProjectBudgetScreen extends StatefulWidget {
  const ProjectBudgetScreen({super.key});

  @override
  State<ProjectBudgetScreen> createState() => _ProjectBudgetScreenState();
}

class _ProjectBudgetScreenState extends State<ProjectBudgetScreen> {
  String selectedProjectType = 'Mô hình Cafe';
  int selectedBottomIndex = 1;

  double get totalActual {
    return actualBudgetItems.fold(
      0,
      (sum, item) => sum + item.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 850;

    return Scaffold(
      backgroundColor: const Color(0xff111b1c),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3b8c91),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: selectedBottomIndex,
        onTap: (index) {
          setState(() {
            selectedBottomIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: isWide ? _buildWideLayout() : _buildPhoneLayout(),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'LẬP KẾ HOẠCH TÀI CHÍNH DỰ ÁN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 22),

        BudgetSummaryCard(
          selectedProjectType: selectedProjectType,
          onProjectChanged: (value) {
            setState(() {
              selectedProjectType = value!;
            });
          },
        ),

        const SizedBox(height: 24),

        _buildActualList(),

        const SizedBox(height: 24),

        BudgetChartCard(
          title: 'BIỂU ĐỒ PHÂN BỔ NGÂN SÁCH',
          subtitle: 'PHÂN BỔ THỰC TẾ',
          items: actualBudgetItems,
          totalText: 'TỔNG CHI: ${formatMoney(totalActual)} VNĐ',
        ),
      ],
    );
  }

  Widget _buildWideLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LẬP KẾ HOẠCH TÀI CHÍNH DỰ ÁN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 28),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BudgetSummaryCard(
                  selectedProjectType: selectedProjectType,
                  onProjectChanged: (value) {
                    setState(() {
                      selectedProjectType = value!;
                    });
                  },
                ),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: _buildActualList(),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: BudgetChartCard(
                  title: 'BIỂU ĐỒ PHÂN BỔ NGÂN SÁCH',
                  subtitle: 'PHÂN BỔ THỰC TẾ',
                  items: actualBudgetItems,
                  totalText: 'TỔNG CHI: ${formatMoney(totalActual)} VNĐ',
                ),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: BudgetChartCard(
                  title: 'BIỂU ĐỒ CHUẨN MÔ HÌNH CAFE',
                  subtitle: 'MÔ HÌNH CHUẨN',
                  items: standardBudgetItems,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActualList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HẠNG MỤC CHI PHÍ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        ...actualBudgetItems.map(
          (item) => BudgetItemCard(item: item),
        ),
      ],
    );
  }
}