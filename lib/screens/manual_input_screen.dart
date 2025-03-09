import 'package:flutter/material.dart';
import '../models/bill.dart';
import '../services/bill_service.dart';

class ManualInputScreen extends StatefulWidget {
  final BillService billService;

  ManualInputScreen({required this.billService});

  @override
  _ManualInputScreenState createState() => _ManualInputScreenState();
}

class _ManualInputScreenState extends State<ManualInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _restaurantController = TextEditingController();
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _taxPercentageController = TextEditingController();

  double _totalAmount = 0.0;
  double _taxAmount = 0.0;

  void _calculateTotal() {
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final taxPercentage = double.tryParse(_taxPercentageController.text) ?? 0.0;

    // Hitung pajak berdasarkan persentase
    _taxAmount = price * (taxPercentage / 100);

    // Hitung total amount
    setState(() {
      _totalAmount = price + _taxAmount;
    });
  }

  void _submitBill() {
    if (_formKey.currentState!.validate()) {
      final newBill = Bill(
        id: DateTime.now().toString(),
        title: _restaurantController.text,
        amount: _totalAmount,
      );

      widget.billService.addBill(newBill);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Manual', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF365486),
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF365486), Color(0xFF0F1035)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _restaurantController,
                  decoration: InputDecoration(
                    labelText: 'Nama Restoran',
                    labelStyle: TextStyle(color: Color(0xFF0F1035)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7FC7D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF365486)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan nama restoran';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _itemController,
                  decoration: InputDecoration(
                    labelText: 'Nama Item',
                    labelStyle: TextStyle(color: Color(0xFF0F1035)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7FC7D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF365486)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan nama item';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    labelStyle: TextStyle(color: Color(0xFF0F1035)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7FC7D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF365486)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan harga';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Harap masukkan angka yang valid';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _calculateTotal();
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _taxPercentageController,
                  decoration: InputDecoration(
                    labelText: 'Pajak (%)',
                    labelStyle: TextStyle(color: Color(0xFF0F1035)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7FC7D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF365486)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan persentase pajak';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Harap masukkan angka yang valid';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _calculateTotal();
                  },
                ),
                SizedBox(height: 24),
                Text(
                  'Pajak: Rp${_taxAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, color: Color(0xFF0F1035)),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Amount: Rp${_totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F1035)),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitBill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF365486),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('Simpan', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}