class Expense {
  final String title;
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  const Expense({
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
