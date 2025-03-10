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
        isActive: false, 
        date: _bills[billIndex].date,
        numberOfItems: _bills[billIndex].numberOfItems,
        numberOfPersons: _bills[billIndex].numberOfPersons,
        users: _bills[billIndex].users,
      );
    }
  }

  void removeBill(String id) {
    _bills.removeWhere((bill) => bill.id == id);
  }

  Bill getBillById(String id) {
    return _bills.firstWhere(
      (bill) => bill.id == id,
      orElse: () => throw Exception('Bill with id $id not found'),
    );
  }

  void updateBill(String id, Bill updatedBill) {
    final billIndex = _bills.indexWhere((bill) => bill.id == id);
    if (billIndex != -1) {
      _bills[billIndex] = updatedBill;
    }
  }
}