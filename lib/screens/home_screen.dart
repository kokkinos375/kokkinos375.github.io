import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../widgets/company_tile.dart';
import '../widgets/gemini_chat_widget.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Company> companies = [
    Company(
      name: 'Google',
      color: Color(0xFF4285F4),
      icon: Icons.search,
      description: 'Search, Cloud, AI',
    ),
    Company(
      name: 'Amazon',
      color: Color(0xFFFF9900),
      icon: Icons.shopping_cart,
      description: 'E-commerce, AWS',
    ),
    Company(
      name: 'Instagram',
      color: Color(0xFFE4405F),
      icon: Icons.camera_alt,
      description: 'Social Media',
    ),
    Company(
      name: 'Microsoft',
      color: Color(0xFF00BCF2),
      icon: Icons.computer,
      description: 'Software, Cloud',
    ),
    Company(
      name: 'Apple',
      color: Color(0xFF000000),
      icon: Icons.phone_iphone,
      description: 'Technology',
    ),
    Company(
      name: 'Meta',
      color: Color(0xFF1877F2),
      icon: Icons.public,
      description: 'Social Media, VR',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Company Chat',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red[600]),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE53E3E), Color(0xFFD53F8C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Choose a company to start chatting or get help from your AI assistant',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          
          // Companies Grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return CompanyTile(
                    company: company,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(company: company),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      
      // Floating AI Assistant Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => GeminiChatWidget(),
          );
        },
        backgroundColor: Color(0xFF4285F4),
        icon: Icon(Icons.psychology, color: Colors.white),
        label: Text(
          'AI Helper',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class Company {
  final String name;
  final Color color;
  final IconData icon;
  final String description;

  Company({
    required this.name,
    required this.color,
    required this.icon,
    required this.description,
  });
}