/// Documentation Demo - Test all documented functions here!
/// 
/// Place your cursor on any function/class name below to see the documentation
/// tooltips in your IDE. This demonstrates all the perfectly documented
/// functions from your Tourify project.
library;

import 'package:firebase_core/firebase_core.dart';

import 'models/memory_entry.dart';
import 'models/city_memory.dart';
import 'services/firebase_service.dart';
import 'main.dart';

/// Demo function showing all documented classes and methods.
/// 
/// Hover over any item below to see the documentation tooltips!
void documentationDemo() {
  // 🎯 HOVER OVER THESE CLASS NAMES TO SEE DOCUMENTATION:
  
  // 1. MemoryEntry class - Core travel memory model
  MemoryEntry memory;
  
  // 2. CityMemory class - City-based memory aggregation
  CityMemory cityMemory;
  
  // 3. FirebaseService class - Firebase operations
  FirebaseService;
  
  // 4. TourifyApp class - Main app widget
  TourifyApp app;
  // 🎯 HOVER OVER THESE CONSTRUCTORS:
  
  // MemoryEntry constructor with all parameters
  memory = MemoryEntry(
    id: 'demo-id',
    title: 'Amazing Sunset',
    story: 'Beautiful sunset at the beach',
    date: DateTime.now(),
    photos: ['photo1.jpg', 'photo2.jpg'],
    cityName: 'Bali',
  );
  
  // CityMemory constructor
  cityMemory = CityMemory(
    cityName: 'Paris',
    photoCount: 25,
    lastVisited: DateTime.now(),
    thumbnailPath: 'assets/paris.jpg',
  );

  // 🎯 HOVER OVER THESE FACTORY CONSTRUCTORS:
  
  // fromJson factory methods
  final jsonData = {'id': 'test', 'title': 'Test', 'story': 'Test story', 
                   'date': '2024-01-01T00:00:00.000Z', 'photos': [], 'cityName': 'Test City'};
  memory = MemoryEntry.fromJson(jsonData);
  
  final cityJsonData = {'id': 'test', 'cityName': 'Test City', 'photoCount': 5,
                       'lastVisited': '2024-01-01T00:00:00.000Z', 'thumbnailPath': 'test.jpg'};
  cityMemory = CityMemory.fromJson(cityJsonData);

  // 🎯 HOVER OVER THESE METHODS:
  
  // JSON conversion methods
  final memoryJson = memory.toJson();
  final cityJson = cityMemory.toJson();
  
  // Copy methods
  final updatedMemory = memory.copyWith(title: 'New Title');
  final updatedCity = cityMemory.copyWith(photoCount: 30);

  // 🎯 HOVER OVER THESE GETTERS:
  
  // MemoryEntry getters
  final photoCount = memory.photoCount;  // The number of photos
  final hasPhotos = memory.hasPhotos;    // Whether this memory has photos
  final formattedDate = memory.formattedDate;  // Formatted date string
  
  // 🎯 HOVER OVER THESE OVERRIDE METHODS:
  
  // toString methods
  final memoryString = memory.toString();
  final cityString = cityMemory.toString();
  
  // Equality operators
  final areEqual = memory == updatedMemory;
  final cityEqual = cityMemory == updatedCity;
  
  // Hash codes
  final memoryHash = memory.hashCode;
  final cityHash = cityMemory.hashCode;

  // 🎯 HOVER OVER THESE FIREBASE SERVICE METHODS:
  
  // Save memory (async method)
  FirebaseService.saveMemory(memory);
  
  // Get memories for city
  FirebaseService.getMemoriesForCity('Paris');
  
  // Get all city memories
  FirebaseService.getAllCityMemories();
  
  // Delete memory
  FirebaseService.deleteMemory('memory-id');
  
  // Update memory
  FirebaseService.updateMemory(memory);

  // 🎯 HOVER OVER THESE PROPERTIES:
  
  // MemoryEntry properties
  final id = memory.id;              // Unique identifier
  final title = memory.title;        // Title or headline
  final story = memory.story;        // Detailed story
  final date = memory.date;          // Creation date
  final photos = memory.photos;      // Photo file paths
  final cityName = memory.cityName;  // Optional city name
  
  // CityMemory properties
  final cityId = cityMemory.id;                    // Unique identifier
  final name = cityMemory.cityName;               // City name
  final count = cityMemory.photoCount;            // Total photos
  final lastVisit = cityMemory.lastVisited;       // Last visit date
  final thumbnail = cityMemory.thumbnailPath;     // Thumbnail path
}

/// Example usage patterns for testing documentation.
/// 
/// Copy these patterns to test documentation tooltips:
class DocumentationTestPatterns {
  
  /// Test MemoryEntry documentation
  void testMemoryEntry() {
    // Hover over MemoryEntry to see class documentation
    final memory = MemoryEntry(
      id: 'test-id',
      title: 'Beach Day',
      story: 'Amazing day at the beach',
      date: DateTime.now(),
      photos: ['beach1.jpg', 'beach2.jpg'],
      cityName: 'Miami',
    );
    
    // Hover over these getters
    print('Photos: ${memory.photoCount}');
    print('Has photos: ${memory.hasPhotos}');
    print('Date: ${memory.formattedDate}');
  }
  
  /// Test CityMemory documentation
  void testCityMemory() {
    // Hover over CityMemory to see class documentation
    final city = CityMemory(
      cityName: 'Tokyo',
      photoCount: 50,
      lastVisited: DateTime.now(),
      thumbnailPath: 'assets/tokyo.jpg',
    );
    
    // Hover over these methods
    final json = city.toJson();
    final copy = city.copyWith(photoCount: 55);
    print(city.toString());
  }
  
  /// Test FirebaseService documentation
  void testFirebaseService() async {
    final memory = MemoryEntry(
      id: 'firebase-test',
      title: 'Firebase Test',
      story: 'Testing Firebase integration',
      date: DateTime.now(),
      photos: [],
    );
    
    // Hover over these static methods
    await FirebaseService.saveMemory(memory);
    final memories = await FirebaseService.getMemoriesForCity('Paris');
    final cities = await FirebaseService.getAllCityMemories();
    await FirebaseService.deleteMemory('test-id');
    await FirebaseService.updateMemory(memory);
  }
}