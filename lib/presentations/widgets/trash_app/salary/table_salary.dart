import 'package:base_app/presentations/widgets/trash_app/salary/item_salary_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TableSalary extends StatefulWidget {
  const TableSalary(
      {super.key,
      required this.salary,
      required this.gross,
      required this.familyBackground,
      required this.insurance});

  final double salary, gross, familyBackground, insurance;

  @override
  State<TableSalary> createState() => _TableSalaryState();
}

class _TableSalaryState extends State<TableSalary> {
  double insurance1 = 0,
      insurance2 = 0,
      insurance3 = 0,
      netIncome = 0,
      netBefore = 0,
      personalIncomeTax = 0;

  final List<String> _title = const [
    'Lương GROSS',
    'Bảo hiểm xã hội (8%)',
    'Bảo hiểm y tế (1.5%)',
    'Bảo hiểm thất nghiệp (1%)',
    'Thu nhập trước thuế',
    'Giảm trừ gia cảnh bản thân',
    'Giảm trừ gia cảnh người phụ thuộc',
    'Thu nhập chịu thuế	',
    'Thuế thu nhập cá nhân',
    'Lương NET',
  ];

  List<double> _tableSalary() {
    _netFromGross();
    return [
      widget.gross,
      -insurance1,
      -insurance2,
      -insurance3,
      netBefore,
      -11000000,
      -widget.familyBackground * 4400000,
      netIncome,
      -_personalIncomeTax(netBefore),
      widget.salary
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  ///Thuế thu nhập cá nhân
  double _personalIncomeTax(double value) {
    double salaryA = 0;
    if (value <= 5000000) {
      salaryA = (value * 0.05);
    } else if (value > 5000000 && value < 10000000) {
      salaryA = (value - 5000000) * 0.1;
    } else if (value > 10000000 && value < 18000000) {
      salaryA = (value - 10000000) * 0.15;
    } else if (value > 18000000 && value < 32000000) {
      salaryA = (value - 18000000) * 0.2;
    } else if (value > 32000000 && value < 52000000) {
      salaryA = (value - 32000000) * 0.25;
    } else if (value > 52000000 && value < 80000000) {
      salaryA = (value - 52000000) * 0.30;
    } else {
      salaryA = (value - 80000000) * 0.35;
    }
    return salaryA + maxPersonalIncomeTax(value);
  }

  /// Các mức nộp tiền max
  double maxPersonalIncomeTax(double value) {
    if (value <= 5000000) {
      return 0;
    } else if (value > 5000000 && value < 10000000) {
      return 250000;
    } else if (value > 10000000 && value < 18000000) {
      return 500000 + 250000;
    } else if (value > 18000000 && value < 32000000) {
      return 1200000 + 500000 + 250000;
    } else if (value > 32000000 && value < 52000000) {
      return 2800000 + 1200000 + 500000 + 250000;
    } else if (value > 52000000 && value < 80000000) {
      return 5000000 + 2800000 + 1200000 + 500000 + 250000;
    } else {
      return 8400000 + 5000000 + 2800000 + 1200000 + 500000 + 250000;
    }
  }

  _netFromGross() {
    setState(() {
      if (widget.gross <= 10000000000) {
        double insuranceA = widget.insurance != 0 ? widget.insurance : widget.gross;

        ///Bảo hiểm xã hội
        insurance1 = insuranceA * 0.08 > 3744000 ? 3744000 : insuranceA * 0.08;

        ///Bảo hiểm y tế
        insurance2 = insuranceA * 0.015 > 702000 ? 702000 : insuranceA * 0.015;

        ///Bảo hiểm thất nghiệp
        insurance3 = insuranceA * 0.01 > 992000 ? 992000 : insuranceA * 0.01;

        ///Thu nhập trước thuế
        netBefore = widget.gross - insurance1 - insurance2 - insurance3;

        ///Thu nhập chịu thuế
        netIncome = widget.gross -
            insurance1 -
            insurance2 -
            insurance3 -
            11000000 -
            widget.familyBackground * 4400000;

        ///Lương NET
        if (netIncome > 0) {
          personalIncomeTax = _personalIncomeTax(netIncome);
        } else {
          personalIncomeTax = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _tableSalary()
          .mapIndexed(
            (index, e) => ItemSalarySheet(
              title: _title[index],
              value: e.toStringAsFixed(0),
            ),
          )
          .toList(),
    );
  }
}
