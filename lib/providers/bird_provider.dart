import 'package:flutter/foundation.dart';
import '../models/bird.dart';
import '../services/bird_service.dart';

class BirdProvider with ChangeNotifier {
  final BirdService _birdService = BirdService();
  List<Bird> _birds = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Bird> get birds => _birds;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch all birds
  Future<void> fetchBirds() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _birds = await _birdService.getBirds();
    } catch (e) {
      _errorMessage = e.toString();
      _birds = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create new bird
  Future<bool> createBird(Bird bird) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newBird = await _birdService.createBird(bird);
      _birds.add(newBird);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update bird
  Future<bool> updateBird(int id, Bird bird) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedBird = await _birdService.updateBird(id, bird);
      final index = _birds.indexWhere((b) => b.id == id);
      if (index != -1) {
        _birds[index] = updatedBird;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete bird
  Future<bool> deleteBird(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _birdService.deleteBird(id);
      _birds.removeWhere((bird) => bird.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

