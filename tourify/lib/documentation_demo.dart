/// Tourify Documentation Demo
/// 
/// This file demonstrates all documented classes and methods.
/// Hover over any class, method, or property to see documentation.
/// 
/// Developer: NAHIAN SYED AHANAF (ID: 2212705042)
library documentation_demo;

// Import all documented libraries
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'models/city_memory.dart';
import 'models/memory_entry.dart';
import 'screens/memory_screen.dart';
import 'screens/add_city_screen.dart';
import 'screens/add_memory_screen.dart';
import 'screens/city_memory_detail_screen.dart';
import 'services/firebase_service.dart';
import 'theme/app_theme.dart';

/// Documentation Demo Class
/// 
/// Hover over any class, method, or property to see documentation.
/// Major documentation showcased first.
class DocumentationDemo {
  
  /// 1. FIREBASE SERVICE - MAJOR DOCUMENTATION
  /// Hover over [FirebaseService] methods to see comprehensive service documentation
  static Future<void> demonstrateFirebaseService() async {
    final memory = MemoryEntry(
      id: 'demo-id',
      title: 'Demo Memory',
      story: 'This is a demo memory entry',
      date: DateTime.now(),
      photos: [],
      cityName: 'Demo City',
    );
    
    // MAJOR: Hover over these Firebase methods to see detailed documentation
    await FirebaseService.saveMemory(memory);
    await FirebaseService.getMemoriesForCity('Dhaka');
    await FirebaseService.getAllCityMemories();
    await FirebaseService.updateMemory(memory);
    await FirebaseService.deleteMemory('demo-id');
  }
  
  /// 2. DATA MODELS - MAJOR DOCUMENTATION
  ///
  /// Hover over these classes to see comprehensive model documentation
  static void demonstrateDataModels() {
    // MAJOR: Hover over CityMemory to see complete documentation
    final cityMemory = CityMemory(
      cityName: 'Dhaka',
      photoCount: 15,
      lastVisited: DateTime.now(),
      thumbnailPath: 'assets/images/dhaka.jpg',
    );
    
    // MAJOR: Hover over MemoryEntry to see complete documentation
    final memoryEntry = MemoryEntry(
      id: 'demo-memory-1',
      title: 'Beautiful Sunset',
      story: 'Amazing evening with breathtaking colors',
      date: DateTime.now(),
      photos: ['photo1.jpg', 'photo2.jpg'],
      cityName: 'Dhaka',
    );
    
    // MAJOR: Hover over these properties to see documentation
    cityMemory.cityName;
    cityMemory.photoCount;
    cityMemory.lastVisited;
    cityMemory.copyWith;
    cityMemory.toJson;
    cityMemory.fromJson;
    
    memoryEntry.title;
    memoryEntry.story;
    memoryEntry.hasPhotos;
    memoryEntry.photoCount;
    memoryEntry.formattedDate;
    memoryEntry.copyWith;
    memoryEntry.toJson;
    memoryEntry.fromJson;
  }
  
  /// 3. SCREEN COMPONENTS - MAJOR DOCUMENTATION
  /// Hover over these screen classes to see comprehensive UI documentation
  static void demonstrateScreens() {
    // MAJOR: Hover over MemoryScreen to see main screen documentation
    const memoryScreen = MemoryScreen();
    
    // MAJOR: Hover over CityMemoryDetailScreen to see detail screen documentation
    final cityDetailScreen = CityMemoryDetailScreen(
      cityMemory: CityMemory(
        cityName: 'Dhaka',
        photoCount: 15,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/dhaka.jpg',
      ),
    );
    
    // MAJOR: Hover over AddMemoryScreen to see add memory documentation
    const addMemoryScreen = AddMemoryScreen(cityName: 'Dhaka');
    
    // MAJOR: Hover over AddCityScreen to see add city documentation
    const addCityScreen = AddCityScreen();
  }
  
  /// 4. THEME SYSTEM - MAJOR DOCUMENTATION
  /// Hover over [AppTheme] to see comprehensive theme documentation
  static void demonstrateTheme() {
    // MAJOR: Hover over these theme properties to see documentation
    AppTheme.primaryNavy;
    AppTheme.secondaryNavy;
    AppTheme.goldAccent;
    AppTheme.darkNavy;
    AppTheme.lightNavy;
    
    // MAJOR: Hover over these theme methods to see documentation
    AppTheme.glassContainer(child: const Text('Demo'));
    AppTheme.premiumTheme();
    AppTheme.navyGradient();
    AppTheme.goldAccentGradient();
    AppTheme.premiumBackground();
  }
  
  /// 5. FIREBASE CONFIGURATION - SUPPORTING DOCUMENTATION
  /// Hover over [DefaultFirebaseOptions] to see Firebase setup documentation
  static void demonstrateFirebaseConfig() {
    // Hover over DefaultFirebaseOptions to see configuration documentation
    final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
    final androidOptions = DefaultFirebaseOptions.android;
  }
}