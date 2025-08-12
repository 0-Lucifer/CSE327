import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'AuthScreen.dart'; // Import the new AuthScreen
import 'firebase_options.dart';

/// Entry point of the Flutter application.
///
/// Initializes Firebase and starts the app with the [AuthScreen] as the
/// initial screen.
void main() async {
  // Ensure Flutter bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app with MaterialApp as the root widget
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Disable debug banner
    home: AuthScreen(), // Set AuthScreen as the initial screen
  ));
}