// lib/presentation/providers/ui_provider.dart
import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  // Mock data for UI demonstration
  String _currentLocation = 'Colombo 07';
  int _safetyScore = 78;
  bool _isTracking = true;

  // Emergency contacts mock data
  final List<Map<String, dynamic>> _emergencyContacts = [
    {
      'name': 'Dad',
      'phone': '+94 77 123 4567',
      'selected': true,
    },
    {
      'name': 'Mom',
      'phone': '+94 71 987 6543',
      'selected': true,
    },
    {
      'name': 'Sister',
      'phone': '+94 76 555 1234',
      'selected': true,
    },
  ];

  // Chat messages mock data
  final List<Map<String, dynamic>> _chatMessages = [
    {
      'text': "Hello! I'm your AI Safety Assistant. How can I help you today?",
      'isUser': false,
      'time': '12:30 PM',
    },
  ];

  // Getters
  String get currentLocation => _currentLocation;
  int get safetyScore => _safetyScore;
  bool get isTracking => _isTracking;
  List<Map<String, dynamic>> get emergencyContacts => _emergencyContacts;
  List<Map<String, dynamic>> get chatMessages => _chatMessages;

  // Methods
  void toggleTracking() {
    _isTracking = !_isTracking;
    notifyListeners();
  }

  void updateSafetyScore(int score) {
    _safetyScore = score;
    notifyListeners();
  }

  void addChatMessage(String text, bool isUser) {
    _chatMessages.add({
      'text': text,
      'isUser': isUser,
      'time': _formatTime(DateTime.now()),
    });
    notifyListeners();
  }

  void toggleContactSelection(int index) {
    _emergencyContacts[index]['selected'] =
        !_emergencyContacts[index]['selected'];
    notifyListeners();
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
