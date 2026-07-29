import 'package:hive_ce/hive.dart';

part 'income.g.dart';

@HiveType(typeId: 1)
class Income extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String source;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime date;

  Income({
    required this.title,
    required this.amount,
    required this.source,
    required this.description,
    required this.date,
  });

  Income copyWith({
    String? title,
    double? amount,
    String? source,
    String? description,
    DateTime? date,
  }) {
    return Income(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      source: source ?? this.source,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Income(title: $title, amount: $amount, source: $source, date: $date)';
  }
}
