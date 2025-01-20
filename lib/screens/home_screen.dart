import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<dynamic>> fetchProducts() async {
    final token = await getToken();
    return _apiService.fetchProducts(token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void refreshProducts() {
    setState(() {
      _productsFuture = fetchProducts();
    });
  }

  void showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add List'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final token = await getToken();
              final success = await _apiService.addProduct(
                token,
                nameController.text,
                double.parse(priceController.text),
                descController.text,
              );
              if (success) {
                refreshProducts();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void showEditProductDialog(Map<String, dynamic> product) {
    final nameController = TextEditingController(text: product['prod_name']);
    final priceController = TextEditingController(text: product['prod_price'].toString());
    final descController = TextEditingController(text: product['prod_desc']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final token = await getToken();
              final success = await _apiService.updateProduct(
                token,
                product['id'],
                nameController.text,
                double.parse(priceController.text),
                descController.text,
              );
              if (success) {
                refreshProducts();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-do-List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: showAddProductDialog,
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 160, 210, 252),
        child: FutureBuilder<List<dynamic>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final products = snapshot.data ?? [];

              return Column(
                children: [
                  SizedBox(
                    height: 200, // Fixed height for the GridView
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // Single row
                        childAspectRatio: 1.5, // Adjust aspect ratio
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                product['prod_name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // ListView for vertical scrolling
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          title: Text(product['prod_name']),
                          subtitle: Text(
                            '${product['prod_desc']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => showEditProductDialog(product),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final token = await getToken();
                                  final success = await _apiService.deleteProduct(token, product['id']);
                                  if (success) {
                                    refreshProducts();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/account');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }
}
