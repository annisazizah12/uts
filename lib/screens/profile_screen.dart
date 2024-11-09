import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Ubah Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
