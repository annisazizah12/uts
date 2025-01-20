import 'package:flutter/material.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 160, 210, 252), 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              const SizedBox(height: 20),
              const Text(
                'Welcome to My To-do-List Apps',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
