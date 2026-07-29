import 'package:hive_ce/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  Expense copyWith({
    String? title,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
  }) {
    return Expense(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Expense(title: $title, amount: $amount, category: $category, date: $date)';
  }
}
