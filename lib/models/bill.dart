class Bill {
  final String id;
  final String title;
  final double amount;
  final bool isActive;
  final DateTime date;
  final int numberOfItems;
  final int numberOfPersons;
  final List<String> users;

  Bill({
    required this.id,
    required this.title,
    required this.amount,
    this.isActive = true,
    required this.date,
    required this.numberOfItems,
    required this.numberOfPersons,
    required this.users,
  });
}