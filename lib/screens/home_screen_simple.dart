import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main_simple.dart';

class HomeScreenSimple extends StatelessWidget {
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
              Provider.of<SimpleAuthProvider>(context, listen: false).signOut();
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
                  return CompanyTileSimple(
                    company: company,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreenSimple(company: company),
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('AI Assistant'),
              content: Text('AI Assistant feature - would integrate with Gemini AI in full version!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
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

class CompanyTileSimple extends StatelessWidget {
  final Company company;
  final VoidCallback onTap;

  const CompanyTileSimple({
    Key? key,
    required this.company,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: company.color.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Company Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: company.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                company.icon,
                size: 30,
                color: company.color,
              ),
            ),
            SizedBox(height: 16),
            
            // Company Name
            Text(
              company.name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            
            // Company Description
            Text(
              company.description,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            
            // Chat Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: company.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: company.color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Chat Now',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: company.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreenSimple extends StatelessWidget {
  final Company company;

  const ChatScreenSimple({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: company.color,
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
                company.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              company.name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              company.icon,
              size: 100,
              color: company.color.withOpacity(0.5),
            ),
            SizedBox(height: 20),
            Text(
              'Chat with ${company.name}',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This is a demo version.\nFull chat functionality would be here!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}