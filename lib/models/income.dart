class Income {
  final String title;
  final double amount;
  final String source;
  final String description;
  final DateTime date;

  const Income({
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
