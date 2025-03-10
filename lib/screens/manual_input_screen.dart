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
  final _taxPercentageController = TextEditingController();
  final _numberOfPersonsController = TextEditingController();
  final _usersController = TextEditingController();

  // Daftar untuk menyimpan nama makanan dan harga
  List<Map<String, TextEditingController>> _items = [
    {
      'name': TextEditingController(),
      'price': TextEditingController(),
    }
  ];

  double _totalAmount = 0.0;
  double _taxAmount = 0.0;

  void _calculateTotal() {
    double totalPrice = 0.0;

    // Hitung total harga dari semua item
    for (var item in _items) {
      final price = double.tryParse(item['price']!.text) ?? 0.0;
      totalPrice += price;
    }

    // Hitung pajak berdasarkan persentase
    final taxPercentage = double.tryParse(_taxPercentageController.text) ?? 0.0;
    _taxAmount = totalPrice * (taxPercentage / 100);

    // Hitung total amount
    setState(() {
      _totalAmount = totalPrice + _taxAmount;
    });
  }

  void _addNewItem() {
    setState(() {
      _items.add({
        'name': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  void _submitBill() {
    if (_formKey.currentState!.validate()) {
      final numberOfPersons = int.parse(_numberOfPersonsController.text);
      final users = _usersController.text.split(',');

      final newBill = Bill(
        id: DateTime.now().toString(),
        title: _restaurantController.text,
        amount: _totalAmount,
        isActive: true,
        date: DateTime.now(),
        numberOfItems: _items.length,
        numberOfPersons: numberOfPersons,
        users: users,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Nama Restoran
                Text(
                  'Nama Restoran',
                  style: TextStyle(color: Color(0xFF7FC7D9), fontSize: 16),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _restaurantController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
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

                // Daftar Input Nama Makanan dan Harga
                ..._items.map((item) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: item['name'],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Nama Makanan',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap masukkan nama makanan';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: item['price'],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Harga',
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
                      ),
                    ],
                  );
                }).toList(),

                // Tombol Tambah Item Baru
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _addNewItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7FC7D9),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text('+ Tambah Item', style: TextStyle(color: Color(0xFF0F1035))),
                  ),
                ),
                SizedBox(height: 16),

                // Input Jumlah Orang
                Text(
                  'Jumlah Orang',
                  style: TextStyle(color: Color(0xFF7FC7D9), fontSize: 16),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _numberOfPersonsController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan jumlah orang';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harap masukkan angka yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Input Daftar User
                Text(
                  'Daftar User (pisahkan dengan koma)',
                  style: TextStyle(color: Color(0xFF7FC7D9), fontSize: 16),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _usersController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan daftar user';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Input Pajak
                Text(
                  'Pajak (%)',
                  style: TextStyle(color: Color(0xFF7FC7D9), fontSize: 16),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _taxPercentageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
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

                // Tampilkan Pajak dan Total Amount
                Text(
                  'Pajak: Rp${_taxAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Amount: Rp${_totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 24),

                // Tombol Simpan
                Center(
                  child: ElevatedButton(
                    onPressed: _submitBill,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7FC7D9),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text('Simpan', style: TextStyle(color: Color(0xFF0F1035))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}