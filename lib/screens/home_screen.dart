import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman Login
import '../models/bill.dart';
import '../services/bill_service.dart';
import '../widgets/bill_item.dart';
import 'receipt_camera_screen.dart';
import 'manual_input_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final BillService _billService = BillService();
  late TabController _tabController;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Animasi fade-in
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Animasi slide-in
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Mulai animasi
    _controller.forward();

    // Tab controller
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _markBillAsCompleted(String id) {
    setState(() {
      _billService.markBillAsCompleted(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Split Bill', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF365486),
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Navigasi kembali ke halaman Login
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => LoginScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 235, 235, 235), Color.fromARGB(255, 253, 253, 253)],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [

            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ListView.builder(
                  itemCount: _billService.activeBills.length,
                  itemBuilder: (ctx, index) {
                    final bill = _billService.activeBills[index];
                    return BillItem(
                      bill,
                      onComplete: () => _markBillAsCompleted(bill.id),
                    );
                  },
                ),
              ),
            ),
            // Tab History Bills
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ListView.builder(
                  itemCount: _billService.historyBills.length,
                  itemBuilder: (ctx, index) {
                    final bill = _billService.historyBills[index];
                    return BillItem(bill);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              // final imagePath = await Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => ReceiptCameraScreen(),
              //   ),
              // );

              // if (imagePath != null) {
              //   // Proses deteksi teks
              // }
            },
            backgroundColor: Color.fromARGB(255, 86, 116, 168),
            child: Icon(Icons.camera_alt, color: Colors.white),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ManualInputScreen(billService: _billService),
                ),
              );
            },
            backgroundColor: Color(0xFF7FC7D9),
            child: Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
    );
  }
}