import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Container(
        color: const Color.fromARGB(255, 160, 210, 252), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true, 
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Ubah Profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
