import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider with ChangeNotifier {
  static const String _apiKey = 'YOUR_GEMINI_API_KEY'; // Replace with actual API key
  late GenerativeModel _model;
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  
  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  
  GeminiProvider() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
    );
  }
  
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    // Add user message
    _messages.add(ChatMessage(
      message: message,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
    
    _isLoading = true;
    notifyListeners();
    
    try {
      final content = [Content.text(message)];
      final response = await _model.generateContent(content);
      
      // Add AI response
      _messages.add(ChatMessage(
        message: response.text ?? 'Sorry, I couldn\'t generate a response.',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _messages.add(ChatMessage(
        message: 'Sorry, there was an error: $e',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}

class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  
  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });
}