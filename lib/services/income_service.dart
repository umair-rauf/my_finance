import '../models/income.dart';

class IncomeService {
  static final List<Income> _incomes = [];

  static List<Income> get incomes => _incomes;

  static void addIncome(Income income) {
    _incomes.add(income);
  }

  static double get totalIncome {
    return _incomes.fold(0.0, (sum, income) => sum + income.amount);
  }
}
