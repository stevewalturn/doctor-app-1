import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class ApiService with ListenableServiceMixin {
  final String baseUrl = 'https://api.example.com/v1';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
    notifyListeners();
  }

  void removeAuthToken() {
    _headers.remove('Authorization');
    notifyListeners();
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      final Map<String, dynamic> errorBody = json.decode(response.body);
      final String errorMessage = errorBody['message'] ?? 'An error occurred';
      throw HttpException(errorMessage, response.statusCode);
    }
  }

  String _handleError(dynamic error) {
    if (error is HttpException) {
      return error.message;
    } else if (error is http.ClientException) {
      return 'Network error occurred. Please check your internet connection.';
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() => message;
}