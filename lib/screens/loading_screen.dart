import 'package:flutter/material.dart';
import 'home_screen.dart'; 
import 'package:lottie/lottie.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;



  goToLandingPage() async {
    
      // await databaseHelper.initDatabase();
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    } 
  }

  @override
  void initState() {
    goToLandingPage();
    super.initState();

          // Animasi controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Animasi fade-in
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Animasi scale
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Mulai animasi
    _controller.forward();

    // Setelah 2 detik, pindah ke HomeScreen
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (ctx) => HomeScreen(),
    //     ),
    //   );
    // });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF365486), Color(0xFF0F1035)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animasi scale untuk logo atau ikon
              ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              // Animasi fade-in untuk teks
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Lottie.asset(
                'lib/assets/animations/loading.json', // Path ke file Lottie JSON
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}