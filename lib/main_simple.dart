import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen_simple.dart';
import 'screens/home_screen_simple.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Skip Firebase for testing
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SimpleAuthProvider(),
      child: MaterialApp(
        title: 'Company Chat App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleAuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
          );
        }
        
        if (authProvider.isLoggedIn) {
          return HomeScreenSimple();
        } else {
          return LoginScreenSimple();
        }
      },
    );
  }
}

class SimpleAuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  
  Future<void> signIn() async {
    _isLoading = true;
    notifyListeners();
    
    // Simulate sign in delay
    await Future.delayed(Duration(seconds: 2));
    
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
  }
  
  void signOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}