import '../models/income.dart';

class IncomeService {
  // Private list to store all incomes
  static final List<Income> _incomes = [];

  // Read-only access to the income list
  static List<Income> get incomes => List.unmodifiable(_incomes);

  // Add a new income
  static void addIncome(Income income) {
    _incomes.add(income);
  }

  // Remove a single income
  static void removeIncome(Income income) {
    _incomes.remove(income);
  }

  // Remove all incomes
  static void clearIncomes() {
    _incomes.clear();
  }

  // Calculate total income
  static double get totalIncome {
    return _incomes.fold<double>(
      0.0,
      (double sum, Income income) => sum + income.amount,
    );
  }

  // Number of income records
  static int get incomeCount => _incomes.length;

  // Check if there are no income records
  static bool get isEmpty => _incomes.isEmpty;

  // Check if there are income records
  static bool get isNotEmpty => _incomes.isNotEmpty;
}
