import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/home_screen.dart';

class ChatScreen extends StatefulWidget {
  final Company company;

  const ChatScreen({Key? key, required this.company}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<CompanyChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(
      CompanyChatMessage(
        message: 'Hello! Welcome to ${widget.company.name}. How can we help you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();
    setState(() {
      _messages.add(
        CompanyChatMessage(
          message: userMessage,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    _messageController.clear();

    // Simulate company response
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          CompanyChatMessage(
            message: _getCompanyResponse(userMessage),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  String _getCompanyResponse(String userMessage) {
    switch (widget.company.name) {
      case 'Google':
        return 'Thank you for reaching out to Google! We\'re here to help with search, cloud services, and AI solutions. What specific area are you interested in?';
      case 'Amazon':
        return 'Hello from Amazon! Whether you need help with shopping, AWS services, or our marketplace, we\'re here to assist you.';
      case 'Instagram':
        return 'Hey there! Welcome to Instagram support. How can we help you with your social media experience today?';
      case 'Microsoft':
        return 'Hi! This is Microsoft support. We can help you with Windows, Office, Azure, or any other Microsoft products and services.';
      case 'Apple':
        return 'Hello from Apple! We\'re here to help with all your Apple products and services. What can we assist you with?';
      case 'Meta':
        return 'Hi! Welcome to Meta support. We can help with Facebook, Instagram, WhatsApp, or our VR/AR technologies.';
      default:
        return 'Thank you for your message! Our team will get back to you shortly.';
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: widget.company.color,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.company.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.company.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Online now',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Input Field
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.company.color,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(CompanyChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isUser 
              ? widget.company.color 
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.message,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: message.isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class CompanyChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  CompanyChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });
}