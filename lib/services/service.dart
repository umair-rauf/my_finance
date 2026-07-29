import '../models/expense.dart';

class ExpenseService {
  static final List<Expense> expenses = [];

  static void addExpense(Expense expense) {
    expenses.add(expense);
  }

  static double getTotalExpenses() {
    double total = 0;

    for (var expense in expenses) {
      total += expense.amount;
    }

    return total;
  }
}
