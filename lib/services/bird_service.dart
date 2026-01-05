import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bird.dart';
import 'api_config.dart';
import 'auth_service.dart';

class BirdService {
  final AuthService _authService = AuthService();

  // Get all birds
  Future<List<Bird>> getBirds() async {
    try {
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse(ApiConfig.birdsEndpoint),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Bird.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else {
        throw Exception('Failed to load birds: ${response.statusCode}');
      }
    } catch (e) {
      // Log error in development
      // ignore: avoid_print
      print('Error fetching birds: $e');
      rethrow;
    }
  }

  // Get bird by ID
  Future<Bird> getBirdById(int id) async {
    try {
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${ApiConfig.birdsEndpoint}/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Bird.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('Bird not found');
      } else {
        throw Exception('Failed to load bird: ${response.statusCode}');
      }
    } catch (e) {
      // Log error in development
      // ignore: avoid_print
      print('Error fetching bird: $e');
      rethrow;
    }
  }

  // Create new bird
  Future<Bird> createBird(Bird bird) async {
    try {
      final headers = await _authService.getAuthHeaders();
      final response = await http.post(
        Uri.parse(ApiConfig.birdsEndpoint),
        headers: headers,
        body: jsonEncode(bird.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Bird.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else {
        throw Exception('Failed to create bird: ${response.statusCode}');
      }
    } catch (e) {
      // Log error in development
      // ignore: avoid_print
      print('Error creating bird: $e');
      rethrow;
    }
  }

  // Update bird (full update)
  Future<Bird> updateBird(int id, Bird bird) async {
    try {
      final headers = await _authService.getAuthHeaders();
      final response = await http.put(
        Uri.parse('${ApiConfig.birdsEndpoint}/$id'),
        headers: headers,
        body: jsonEncode(bird.toJson()),
      );

      if (response.statusCode == 200) {
        return Bird.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('Bird not found');
      } else {
        throw Exception('Failed to update bird: ${response.statusCode}');
      }
    } catch (e) {
      // Log error in development
      // ignore: avoid_print
      print('Error updating bird: $e');
      rethrow;
    }
  }

  // Update bird (partial update)
  Future<Bird> patchBird(int id, Map<String, dynamic> updates) async {
    try {
      final headers = await _authService.getAuthHeaders();
      final response = await http.patch(
        Uri.parse('${ApiConfig.birdsEndpoint}/$id'),
        headers: headers,
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        return Bird.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('Bird not found');
      } else {
        throw Exception('Failed to patch bird: ${response.statusCode}');
      }
    } catch (e) {
      // Log error in development
      // ignore: avoid_print
      print('Error patching bird: $e');
      rethrow;
    }
  }

  // Delete bird
  Future<void> deleteBird(int id) async {
    try {
      final headers = await _authService.getAuthHeaders();
      final response = await http.delete(
        Uri.parse('${ApiConfig.birdsEndpoint}/$id'),
        headers: headers,
      );

      if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('Bird not found');
      } else if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete bird: ${response.statusCode}');
      }
    } catch (e) {
      // Log error in development
      // ignore: avoid_print
      print('Error deleting bird: $e');
      rethrow;
    }
  }
}

