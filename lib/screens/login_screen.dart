import 'package:flutter/material.dart';
import '../api_service.dart'; 
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ApiService _apiService = ApiService();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final response = await _apiService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (response['success']) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['access_token']);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil')),
      );

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 160, 210, 252),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo.png', // Pastikan logo berada di folder assets
                    height: 100,
                  ),
                  const SizedBox(height: 20),

                  // Input Email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Masukan Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Input Password
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Masukan Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Tombol Login
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          child: const Text('Masuk'),
                        ),
                  const SizedBox(height: 10),

                  // Lupa Password
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: const Text('Lupa Password?'),
                  ),

                  // Navigasi ke Registrasi
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('Belum punya akun?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
