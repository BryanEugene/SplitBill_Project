class Bill {
  final String id;
  final String title;
  final double amount;
  final bool isActive; // Untuk membedakan antara Active dan History

  Bill({
    required this.id,
    required this.title,
    required this.amount,
    this.isActive = true, // Default: tagihan aktif
  });
}