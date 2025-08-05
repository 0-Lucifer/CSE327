/// Tourify - Premium Travel Memory Diary Application.
/// 
/// A Flutter application for creating and managing travel memories with photos.
/// Features include:
/// - City-based memory organization
/// - Photo storage with Firebase integration
/// - Premium Navy Blue Glass Tempered UI theme
/// - Real-time memory synchronization
/// 
/// The app initializes Firebase services and provides a premium user experience
/// for travel enthusiasts to document their journeys.
library;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/memory_screen.dart';
/// Entry point for the Tourify application.
/// 
/// Starts the Flutter app with Navy Blue Glass Tempered design.
/// Firebase initialization is temporarily disabled to fix white screen.
void main() {
  print('Starting Tourify app...');
  runApp(const TourifyApp());
}

// Commented out Firebase initialization to fix white screen issue
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     print('Firebase error: $e');
//   }
//   
//   runApp(const TourifyApp());
// }

/// Root widget for the Tourify application.
/// 
/// Configures the MaterialApp with Navy Blue Glass Tempered design,
/// sets up navigation, and defines the home screen.
class TourifyApp extends StatelessWidget {
  /// Creates the root Tourify application widget.
  const TourifyApp({super.key});

  /// Builds the MaterialApp with Navy Blue Glass Tempered design.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourify - Travel Memory Diary',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), // Navy Blue
          brightness: Brightness.light,
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFF283593),
          surface: const Color(0xFFF8F9FA),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Color(0xFF1A237E),
        ),
      ),
      home: const MemoryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}