import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

enum GrossOfNet { gross, net, not }

class SalaryWidget extends StatefulWidget {
  const SalaryWidget({super.key});

  @override
  State<SalaryWidget> createState() => _SalaryWidgetState();
}

class _SalaryWidgetState extends State<SalaryWidget> {
  final TextEditingController salaryController = TextEditingController(),
      familyBackgroundController = TextEditingController(),
      insuranceController = TextEditingController();
  double salary = 0, familyBackground = 0, insurance = 0, salaryGross = 0, netSalary = 0;
  GrossOfNet grossOfNet = GrossOfNet.not;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thu nhập: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
          AppInput(
            error: salary > 10000000000 ? 'Tối đa 10 tỷ' : '',
            keyboardType: TextInputType.number,
            controller: salaryController,
            onChange: (value) => setSalary(value),
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          Text(
            'Số người phụ thuộc: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
          AppInput(
            keyboardType: TextInputType.number,
            controller: familyBackgroundController,
            onChange: (value) => setFamilyBackground(value),
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          Text(
            'Mức lương đóng bảo hiểm: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
          AppInput(
            error: insurance > 10000000000 ? 'Tối đa 10 tỷ' : '',
            keyboardType: TextInputType.number,
            controller: insuranceController,
            onChange: (value) => setInsurance(value),
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
                  child: AppButton(
                    title: 'GROSS -> NET',
                    onSubmit: () => _netFromGross(),
                    color: colors.success,
                    colorText: colors.background,
                    colorBorder: colors.success,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
                  child: AppButton(
                    title: 'NET -> GROSS',
                    onSubmit: () => _grossFromNet(),
                    color: colors.background,
                    colorText: colors.success,
                    colorBorder: colors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          Row(
            children: [
              if (grossOfNet == GrossOfNet.net) ...[
                Text(
                  "Lương NET: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                Text(
                  netSalary.toInt().toString(),
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ],
              if (grossOfNet == GrossOfNet.gross) ...[
                Text(
                  "Lương GROSS: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                Text(
                  salaryGross.toInt().toString(),
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }

  ///Thuế thu nhập cá nhân
  double personalIncomeTax(double value) {
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
    if (salary <= 10000000000) {
      double net = 0,
          netIncome = 0,
          netBefore = 0,
          insuranceA = insurance != 0 ? insurance : salary;

      ///Bảo hiểm xã hội
      final insurance1 = insuranceA * 0.08 > 3744000 ? 3744000 : insuranceA * 0.08;

      ///Bảo hiểm y tế
      final insurance2 = insuranceA * 0.015 > 702000 ? 702000 : insuranceA * 0.015;

      ///Bảo hiểm thất nghiệp
      final insurance3 = insuranceA * 0.01 > 992000 ? 992000 : insuranceA * 0.01;

      ///Thu nhập trước thuế
      netBefore = salary - insurance1 - insurance2 - insurance3;

      ///Thu nhập chịu thuế
      netIncome =
          salary - insurance1 - insurance2 - insurance3 - 11000000 - familyBackground * 4400000;

      ///Lương NET
      if (netIncome > 0) {
        net = netBefore - personalIncomeTax(netIncome);
      } else {
        net = salary - (salary * (0.08 + 0.015 + 0.01));
      }
      setState(() {
        netSalary = net;
        grossOfNet = GrossOfNet.net;
      });
    }
  }

  _grossFromNet() {
    if (salary <= 10000000000) {
      double gross = salary;
      double netBefore, netIncome;
      while (true) {
        double insuranceA = insurance != 0 ? insurance : gross;

        ///Bảo hiểm xã hội
        final insurance1 = insuranceA * 0.08 > 3744000 ? 3744000 : insuranceA * 0.08;

        ///Bảo hiểm y tế
        final insurance2 = insuranceA * 0.015 > 702000 ? 702000 : insuranceA * 0.015;

        ///Bảo hiểm thất nghiệp
        final insurance3 = insuranceA * 0.01 > 992000 ? 992000 : insuranceA * 0.01;

        ///Thu nhập trước thuế
        netBefore = gross - insurance1 - insurance2 - insurance3;

        ///Thu nhập chịu thuế
        netIncome =
            gross - insurance1 - insurance2 - insurance3 - 11000000 - familyBackground * 4400000;

        double netNow = 0;

        ///Lương NET
        if (netIncome > 0) {
          netNow = netBefore - personalIncomeTax(netIncome);
        } else {
          netNow = gross - (gross * (0.08 + 0.015 + 0.01));
        }

        /// Nếu netNow bằng net đầu vào thì ok
        if (netNow - salary >= 0) {
          break;
        }

        /// Tăng Gross đến chết
        if (salary <= 1000) {
          gross += 1;
        } else if (salary > 1000 && salary <= 10000) {
          gross += 10;
        } else if (salary > 10000 && salary <= 100000) {
          gross += 100;
        } else if (salary > 100000 && salary <= 10000000) {
          gross += 1000;
        } else if (salary > 10000000 && salary <= 100000000) {
          gross += 10000;
        } else if (salary > 100000000 && salary <= 1000000000) {
          gross += 100000;
        } else {
          gross += 1000000;
        }
      }

      setState(() {
        grossOfNet = GrossOfNet.gross;
        salaryGross = gross;
      });
    }
  }

  setSalary(String value) {
    setState(() {
      salary = double.parse(value.isNotEmpty ? value : '0');
    });
  }

  setFamilyBackground(String value) {
    setState(() {
      familyBackground = double.parse(value.isNotEmpty ? value : '0');
    });
  }

  setInsurance(String value) {
    setState(() {
      insurance = double.parse(value.isNotEmpty ? value : '0');
    });
  }
}
