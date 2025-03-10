import 'package:flutter/material.dart';
import '../models/bill.dart';

class BillItem extends StatelessWidget {
  final Bill bill;
  final VoidCallback? onComplete;

  BillItem(this.bill, {this.onComplete});

  @override
  Widget build(BuildContext context) {

    if(bill == null){
      return Center(child: Text("Bill Tidak Valid"),);
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Color(0xFF7FC7D9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Name and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bill.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F1035),
                  ),
                ),
                Text(
                  '${bill.date.day}/${bill.date.month}/${bill.date.year}',
                  style: TextStyle(color: Color(0xFF0F1035)),
                ),
              ],
            ),
            SizedBox(height: 8),

            Text(
              'Total: Rp${bill.amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Color(0xFF0F1035)),
            ),
            SizedBox(height: 8),

            Text(
              '${bill.numberOfItems} Items ● ${bill.numberOfPersons} Persons',
              style: TextStyle(color: Color(0xFF0F1035)),
            ),
            SizedBox(height: 8),

            Row(
              children: [
                ...bill.users.map((user) {
                  return Container(
                    margin: EdgeInsets.only(right: 4),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Masukin navigasi details screen
                },
                child: Text(
                  'See Details',
                  style: TextStyle(color: Color(0xFF0F1035)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}