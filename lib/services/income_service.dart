import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/income.dart';

class IncomeService {
  static const String boxName = 'incomes';

  static Box<Income> get _box => Hive.box<Income>(boxName);

  // Return all incomes, newest first.
  static List<Income> get incomes {
    final List<Income> items = _box.values.toList();

    items.sort(
      (Income first, Income second) => second.date.compareTo(first.date),
    );

    return items;
  }

  // Add a new income.
  static Future<void> addIncome(Income income) async {
    await _box.add(income);
  }

  // Update an existing income.
  static Future<void> updateIncome(
    Income oldIncome,
    Income updatedIncome,
  ) async {
    final dynamic key = oldIncome.key;

    if (key == null) {
      return;
    }

    await _box.put(key, updatedIncome);
  }

  // Remove one income safely using its Hive key.
  static Future<void> removeIncome(Income income) async {
    final dynamic key = income.key;

    if (key == null) {
      return;
    }

    await _box.delete(key);
  }

  // Remove all incomes.
  static Future<void> clearIncomes() async {
    await _box.clear();
  }

  // Calculate total income.
  static double get totalIncome {
    return _box.values.fold<double>(
      0.0,
      (double total, Income income) => total + income.amount,
    );
  }

  static int get incomeCount => _box.length;

  static bool get isEmpty => _box.isEmpty;

  static bool get isNotEmpty => _box.isNotEmpty;
}
