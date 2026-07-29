import '../models/expense.dart';

class ExpenseService {
  static final List<Expense> _expenses = [];

  static List<Expense> get expenses => _expenses;

  static void addExpense(Expense expense) {
    _expenses.add(expense);
  }

  static double get totalExpense {
    return _expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }
}
