import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.89.76:8000/api'; // Sesuaikan URL backend Anda

  Future<Map<String, dynamic>> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/customers');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cust_email': email, 'cust_password': password}),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Registration successful'};
      } else {
        final error = jsonDecode(response.body);
        return {'success': false, 'message': error['error'] ?? 'Failed to register'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/customers/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cust_email': email, 'cust_password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'access_token': data['access_token']};
      } else {
        final error = jsonDecode(response.body);
        return {'success': false, 'message': error['error'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
   Future<List<dynamic>> fetchProducts(String? token) async {
    final url = Uri.parse('$baseUrl/products');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<bool> addProduct(String? token, String name, double price, String desc) async {
    final url = Uri.parse('$baseUrl/products');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'prod_name': name, 'prod_price': price, 'prod_desc': desc}),
    );

    return response.statusCode == 201;
  }

  Future<bool> updateProduct(String? token, int id, String name, double price, String desc) async {
    final url = Uri.parse('$baseUrl/products?id=$id');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'prod_name': name, 'prod_price': price, 'prod_desc': desc}),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(String? token, int id) async {
    final url = Uri.parse('$baseUrl/products?id=$id');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.statusCode == 200;
  }
  
}