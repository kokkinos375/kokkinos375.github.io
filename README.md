# Company Chat App

A beautiful Flutter application that allows users to authenticate with Google and chat with major companies like Google, Amazon, Instagram, Microsoft, Apple, and Meta. The app also features a Gemini AI personal assistant to help users with any questions or problems.

## Features

- 🔐 **Google Authentication**: Secure login with Google accounts
- 🏢 **Company Chat**: Interactive chat interfaces with major companies
- 🤖 **AI Assistant**: Gemini AI-powered personal helper
- 🎨 **Beautiful UI**: Modern red-themed design with smooth animations
- 📱 **Responsive Design**: Works great on all screen sizes

## Screenshots

The app features:
- A stunning red gradient login screen
- Home screen with company tiles
- Individual chat screens for each company
- Floating AI assistant with modal chat interface

## Setup Instructions

### Prerequisites

1. **Flutter SDK**: Install Flutter (3.24.5 or later)
2. **Firebase Project**: Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
3. **Gemini API Key**: Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)

### Firebase Setup

1. **Create a Firebase Project**:
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Create a project"
   - Enable Google Analytics (optional)

2. **Enable Authentication**:
   - Go to Authentication > Sign-in method
   - Enable Google Sign-in
   - Add your SHA-1 fingerprint for Android

3. **Configure Firebase for Flutter**:
   - Install Firebase CLI: `npm install -g firebase-tools`
   - Login: `firebase login`
   - Install FlutterFire CLI: `dart pub global activate flutterfire_cli`
   - Configure: `flutterfire configure`

4. **Update Firebase Configuration**:
   - Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration

### Gemini AI Setup

1. **Get API Key**:
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a new API key

2. **Update API Key**:
   - Open `lib/providers/gemini_provider.dart`
   - Replace `YOUR_GEMINI_API_KEY` with your actual API key

### Android Setup

1. **Download google-services.json**:
   - In Firebase Console, go to Project Settings
   - Download `google-services.json`
   - Place it in `android/app/`

2. **Update build.gradle files**:
   ```gradle
   // android/build.gradle
   dependencies {
       classpath 'com.google.gms:google-services:4.3.15'
   }

   // android/app/build.gradle
   apply plugin: 'com.google.gms.google-services'
   ```

3. **Get SHA-1 Fingerprint**:
   ```bash
   cd android
   ./gradlew signingReport
   ```

### Installation

1. **Clone and Install**:
   ```bash
   cd company_chat_app
   flutter pub get
   ```

2. **Run the App**:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── providers/
│   ├── auth_provider.dart    # Google authentication logic
│   └── gemini_provider.dart  # Gemini AI integration
├── screens/
│   ├── login_screen.dart     # Beautiful red login screen
│   ├── home_screen.dart      # Main screen with company tiles
│   └── chat_screen.dart      # Individual company chat
└── widgets/
    ├── company_tile.dart     # Company card widget
    └── gemini_chat_widget.dart # AI assistant chat interface
```

## Dependencies

- `firebase_core` & `firebase_auth`: Firebase authentication
- `google_sign_in`: Google Sign-In integration
- `google_generative_ai`: Gemini AI integration
- `provider`: State management
- `google_fonts`: Beautiful typography
- `flutter_svg`: SVG support

## Configuration Notes

### For Production:

1. **Replace API Keys**: Update all placeholder API keys with real ones
2. **Firebase Security**: Configure Firebase security rules
3. **App Signing**: Set up proper app signing for release
4. **Privacy Policy**: Add privacy policy for Google Sign-In

### Troubleshooting:

1. **Build Issues**: Make sure all API keys are correctly set
2. **Authentication**: Verify SHA-1 fingerprint is added to Firebase
3. **Gemini AI**: Ensure API key has proper permissions

## Features in Detail

### Authentication
- Secure Google OAuth integration
- Automatic sign-in state management
- Beautiful loading states and error handling

### Company Chat
- Simulated chat with major companies
- Company-specific responses and branding
- Real-time message interface

### AI Assistant
- Powered by Google's Gemini AI
- Helps with any questions or problems
- Modal chat interface with typing indicators

## License

This project is created for demonstration purposes. Make sure to comply with all third-party service terms of use.

## Support

For setup issues or questions, please check:
1. Flutter documentation
2. Firebase documentation
3. Gemini AI documentation