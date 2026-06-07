import 'package:flutter/material.dart';
import '../models/budget_item.dart';

const List<String> projectTypes = [
  'Mô hình Cafe',
  'Startup Công nghệ',
  'Kinh doanh Bán lẻ',
];

const List<BudgetItem> actualBudgetItems = [
  BudgetItem(
    title: 'Thuê Mặt Bằng',
    amount: 25000000,
    status: 'Trả hẹn',
    percent: 15,
    icon: Icons.apartment,
    color: Color(0xff5bb7b5),
  ),
  BudgetItem(
    title: 'Thiết Kế Thi công',
    amount: 10000000,
    status: 'Thuê nhân',
    percent: 35,
    icon: Icons.construction,
    color: Color(0xffff7a3d),
  ),
  BudgetItem(
    title: 'Thiết Bị & Máy Móc',
    amount: 10000000,
    status: 'Tái trục',
    percent: 25,
    icon: Icons.precision_manufacturing,
    color: Color(0xfff2b94b),
  ),
  BudgetItem(
    title: 'Nguyên liệu đầu vào',
    amount: 12000000,
    status: 'Đang chờ',
    percent: 15,
    icon: Icons.oil_barrel,
    color: Color(0xff8abf55),
  ),
  BudgetItem(
    title: 'Marketing & Khai trương',
    amount: 97500000,
    status: 'Đang chạy',
    percent: 10,
    icon: Icons.campaign,
    color: Color(0xfff0624d),
  ),
];

const List<BudgetItem> standardBudgetItems = [
  BudgetItem(
    title: 'Mặt bằng',
    amount: 0,
    status: '',
    percent: 20,
    icon: Icons.apartment,
    color: Color(0xff5bb7b5),
  ),
  BudgetItem(
    title: 'Thi công',
    amount: 0,
    status: '',
    percent: 30,
    icon: Icons.construction,
    color: Color(0xffff7a3d),
  ),
  BudgetItem(
    title: 'Thiết bị',
    amount: 0,
    status: '',
    percent: 20,
    icon: Icons.precision_manufacturing,
    color: Color(0xffd85c52),
  ),
  BudgetItem(
    title: 'Nguyên liệu',
    amount: 0,
    status: '',
    percent: 15,
    icon: Icons.inventory,
    color: Color(0xfff2b94b),
  ),
  BudgetItem(
    title: 'Marketing',
    amount: 0,
    status: '',
    percent: 10,
    icon: Icons.campaign,
    color: Color(0xffefb44f),
  ),
];