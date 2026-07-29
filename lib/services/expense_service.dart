import '../models/expense.dart';

class ExpenseService {
  // Private list to store all expenses
  static final List<Expense> _expenses = [];

  // Read-only access to the expense list
  static List<Expense> get expenses => List.unmodifiable(_expenses);

  // Add a new expense
  static void addExpense(Expense expense) {
    _expenses.add(expense);
  }

  // Remove a single expense
  static void removeExpense(Expense expense) {
    _expenses.remove(expense);
  }

  // Remove all expenses
  static void clearExpenses() {
    _expenses.clear();
  }

  // Calculate total expense
  static double get totalExpense {
    return _expenses.fold<double>(
      0.0,
      (double sum, Expense expense) => sum + expense.amount,
    );
  }

  // Number of expenses
  static int get expenseCount => _expenses.length;

  // Check if there are no expenses
  static bool get isEmpty => _expenses.isEmpty;

  // Check if there are expenses
  static bool get isNotEmpty => _expenses.isNotEmpty;
}
