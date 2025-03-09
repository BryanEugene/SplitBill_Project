import 'package:flutter/material.dart';
import '../models/bill.dart';

class BillItem extends StatelessWidget {
  final Bill bill;
  final VoidCallback? onComplete;

  BillItem(this.bill, {this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Color(0xFF7FC7D9),
      child: ListTile(
        title: Text(bill.title, style: TextStyle(color: Color(0xFF0F1035))),
        subtitle: Text('Rp${bill.amount.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFF0F1035))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onComplete != null)
              IconButton(
                icon: Icon(Icons.check, color: Color(0xFF0F1035)),
                onPressed: onComplete,
              ),
            IconButton(
              icon: Icon(Icons.delete, color: Color(0xFF0F1035)),
              onPressed: () {
                // Delete bill logic
              },
            ),
          ],
        ),
      ),
    );
  }
}