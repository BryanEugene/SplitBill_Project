import '../models/bill.dart';

class BillService {
  final List<Bill> _bills = [];

  List<Bill> get activeBills => _bills.where((bill) => bill.isActive).toList();
  List<Bill> get historyBills => _bills.where((bill) => !bill.isActive).toList();

  void addBill(Bill bill) {
    _bills.add(bill);
  }

  void markBillAsCompleted(String id) {
    final billIndex = _bills.indexWhere((bill) => bill.id == id);
    if (billIndex != -1) {
      _bills[billIndex] = Bill(
        id: _bills[billIndex].id,
        title: _bills[billIndex].title,
        amount: _bills[billIndex].amount,
        isActive: false, // Tandai sebagai selesai
      );
    }
  }
}