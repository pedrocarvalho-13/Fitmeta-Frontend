// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importe o pacote dotenv
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_profile.dart';

class AuthService {
  final String? _baseUrl = dotenv.env['API_BASE_URL']; // Altere para a URL da sua API

  Future<bool> login(LoginRequest request) async {
    final url = Uri.parse('$_baseUrl/api/Auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final token = response.body; // O token JWT é a resposta
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return true;
    }
    return false;
  }

  Future<bool> register(RegisterRequest request) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<UserProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      return null;
    }

    final url = Uri.parse('$_baseUrl/api/Auth/profile');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}