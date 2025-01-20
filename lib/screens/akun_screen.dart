import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun')),
      body: Container(
        color: const Color.fromARGB(255, 160, 210, 252),
        child: ListView(
          children: [
            Image.asset('assets/foto.jpg'),
            ListTile(
              title: const Text('Kelola Akun'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            const ListTile(title: Text('Notifikasi')),
            const ListTile(title: Text('Privacy Policy')),
            const ListTile(title: Text('Terms of Service')),
          ],
        ),
      ),
    );
  }
}
