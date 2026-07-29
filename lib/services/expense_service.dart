import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/expense.dart';

class ExpenseService {
  static const String boxName = 'expenses';

  static Box<Expense> get _box => Hive.box<Expense>(boxName);

  // Return all expenses, newest first.
  static List<Expense> get expenses {
    final List<Expense> items = _box.values.toList();

    items.sort(
      (Expense first, Expense second) => second.date.compareTo(first.date),
    );

    return items;
  }

  // Add a new expense.
  static Future<void> addExpense(Expense expense) async {
    await _box.add(expense);
  }

  // Update an existing expense.
  static Future<void> updateExpense(
    Expense oldExpense,
    Expense updatedExpense,
  ) async {
    final dynamic key = oldExpense.key;

    if (key == null) {
      return;
    }

    await _box.put(key, updatedExpense);
  }

  // Remove one expense safely using its Hive key.
  static Future<void> removeExpense(Expense expense) async {
    final dynamic key = expense.key;

    if (key == null) {
      return;
    }

    await _box.delete(key);
  }

  // Remove every expense.
  static Future<void> clearExpenses() async {
    await _box.clear();
  }

  // Calculate the total expense amount.
  static double get totalExpense {
    return _box.values.fold<double>(
      0.0,
      (double total, Expense expense) => total + expense.amount,
    );
  }

  static int get expenseCount => _box.length;

  static bool get isEmpty => _box.isEmpty;

  static bool get isNotEmpty => _box.isNotEmpty;
}
