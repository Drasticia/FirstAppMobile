import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  final String baseUrl = 'http://yourapi.com/api';

  Future<bool> login(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle successful login
      return true;
    } else {
      // Handle unsuccessful login
      return false;
    }
  }
}
