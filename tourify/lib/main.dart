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
import 'theme/app_theme.dart';

/// Entry point for the Tourify application.
/// 
/// Initializes Firebase services and starts the Flutter app with
/// premium theming and memory management capabilities.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase error: $e');
  }
  
  runApp(const TourifyApp());
}

/// Root widget for the Tourify application.
/// 
/// Configures the MaterialApp with premium theming, sets up navigation,
/// and defines the home screen as the memory management interface.
class TourifyApp extends StatelessWidget {
  /// Creates the root Tourify application widget.
  const TourifyApp({super.key});

  /// Builds the MaterialApp with premium theme and navigation setup.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourify - Premium Travel Memory Diary',
      theme: AppTheme.premiumTheme,
      home: const MemoryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}