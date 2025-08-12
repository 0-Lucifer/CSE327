/// Firebase integration services for travel memory storage and retrieval.
/// 
/// This library provides comprehensive Firebase operations including:
/// - Memory storage with photo uploads to Firebase Storage
/// - City-based memory aggregation and statistics
/// - Real-time data synchronization with Firestore
/// - Batch operations for efficient data management
/// 
/// The [FirebaseService] class handles all backend operations, abstracting
/// Firebase complexity from the UI layer.
/// 
/// Example usage:
/// ```dart
/// await FirebaseService.saveMemory(memoryEntry);
/// final memories = await FirebaseService.getMemoriesForCity('Paris');
/// ```
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/memory_entry.dart';
import '../models/city_memory.dart';

/// Service class for handling Firebase operations in the Tourify app.
/// 
/// This service provides methods for storing and retrieving travel memories
/// and city data using Firebase Firestore and Firebase Storage.
/// It handles photo uploads, memory management, and city statistics.
class FirebaseService {
  /// Firebase Firestore instance for database operations.
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// Firebase Storage instance for file uploads.
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Collection name for storing memory entries in Firestore.
  static const String _memoriesCollection = 'memories';
  
  /// Collection name for storing city memory data in Firestore.
  static const String _cityMemoriesCollection = 'city_memories';

  /// Saves a memory entry to Firebase with photo uploads.
  /// 
  /// Handles the complete process of saving a memory:
  /// - Uploads new photos to Firebase Storage
  /// - Saves memory data to Firestore
  /// - Updates city memory statistics
  /// 
  /// The [memory] parameter contains the memory entry to save.
  /// 
  /// ```dart
  /// final memory = MemoryEntry(
  ///   id: 'unique-id',
  ///   title: 'Beach Day',
  ///   story: 'Amazing day at the beach',
  ///   date: DateTime.now(),
  ///   photos: ['local/photo1.jpg'],
  ///   cityName: 'Miami',
  /// );
  /// await FirebaseService.saveMemory(memory);
  /// ```
  /// 
  /// Throws [Exception] if the save operation fails.
  static Future<void> saveMemory(MemoryEntry memory) async {
    print('🔥 Starting to save memory: ${memory.id}');
    print('🔥 Memory has ${memory.photos.length} photos');
    
    try {
      // Test Firebase connection first
      print('🔥 Testing Firebase connection...');
      await _firestore.collection('test').doc('connection').set({'test': true});
      print('🔥 Firebase connection successful!');
      
      // Upload photos first (skip if no photos)
      List<String> photoUrls = [];
      
      // Only upload photos if there are any
      if (memory.photos.isNotEmpty) {
        print('🔥 Starting photo uploads...');
        for (int i = 0; i < memory.photos.length; i++) {
          String photoPath = memory.photos[i];
          print('🔥 Processing photo ${i + 1}: $photoPath');
          
          if (photoPath.startsWith('http')) {
            // Already uploaded
            print('🔥 Photo already uploaded: $photoPath');
            photoUrls.add(photoPath);
          } else {
            // Check if file exists
            final file = File(photoPath);
            if (!await file.exists()) {
              print('❌ Photo file does not exist: $photoPath');
              continue;
            }
            
            print('🔥 Uploading new photo: $photoPath');
            try {
              String photoUrl = await _uploadPhoto(file, memory.id);
              print('🔥 Photo uploaded successfully: $photoUrl');
              photoUrls.add(photoUrl);
            } catch (uploadError) {
              print('❌ Failed to upload photo: $uploadError');
              // Continue with other photos or save without this photo
            }
          }
        }
        print('🔥 All photos processed. URLs: $photoUrls');
      } else {
        print('🔥 No photos to upload');
      }

      // Create memory with photo URLs (or empty list)
      final memoryWithUrls = memory.copyWith(photos: photoUrls);
      print('🔥 Saving memory to Firestore...');

      // Save to Firestore
      await _firestore
          .collection(_memoriesCollection)
          .doc(memory.id)
          .set(memoryWithUrls.toJson());
      print('🔥 Memory saved to Firestore successfully');

      // Update city memory count
      print('🔥 Updating city memory count...');
      await _updateCityMemoryCount(memory.cityName ?? 'Unknown');
      print('🔥 City memory count updated');

      print('✅ Memory saved successfully: ${memory.id}');
    } catch (e, stackTrace) {
      print('❌ Error saving memory: $e');
      print('❌ Stack trace: $stackTrace');
      throw Exception('Failed to save memory: $e');
    }
  }

  /// Uploads a photo file to Firebase Storage.
  /// 
  /// Creates a unique filename using timestamp and stores the photo
  /// in a memory-specific folder structure.
  /// 
  /// The [photoFile] parameter is the image file to upload.
  /// The [memoryId] parameter identifies which memory this photo belongs to.
  /// 
  /// Returns the download URL of the uploaded photo.
  /// 
  /// Throws [Exception] if the upload fails.
  static Future<String> _uploadPhoto(File photoFile, String memoryId) async {
    print('📸 Starting photo upload...');
    print('📸 File path: ${photoFile.path}');
    print('📸 File exists: ${await photoFile.exists()}');
    print('📸 File size: ${await photoFile.length()} bytes');
    
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String storagePath = 'memory_photos/$memoryId/$fileName';
      print('📸 Storage path: $storagePath');
      
      final Reference ref = _storage.ref().child(storagePath);
      print('📸 Storage reference created');

      print('📸 Starting upload task with metadata...');
      
      // Add metadata to help with upload
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'memoryId': memoryId,
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );
      
      final UploadTask uploadTask = ref.putFile(photoFile, metadata);
      
      // Monitor upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        print('📸 Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
        print('📸 State: ${snapshot.state}');
      });
      
      // Wait for upload with timeout
      final TaskSnapshot snapshot = await uploadTask.timeout(
        const Duration(minutes: 2),
        onTimeout: () {
          print('❌ Upload timed out after 2 minutes');
          uploadTask.cancel();
          throw Exception('Upload timed out');
        },
      );
      
      print('📸 Upload completed, getting download URL...');
      
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print('📸 Download URL obtained: $downloadUrl');

      return downloadUrl;
    } catch (e, stackTrace) {
      print('❌ Error uploading photo: $e');
      print('❌ Stack trace: $stackTrace');
      
      // Check if it's a specific Firebase Storage error
      if (e.toString().contains('cancelled')) {
        throw Exception('Upload was cancelled - check Firebase Storage rules');
      } else if (e.toString().contains('permission')) {
        throw Exception('Permission denied - check Firebase Storage rules');
      } else {
        throw Exception('Failed to upload photo: $e');
      }
    }
  }

  /// Updates the photo count and last visited date for a city.
  /// 
  /// Uses a Firestore transaction to safely increment the photo count
  /// and update the last visited timestamp. Creates a new city entry
  /// if this is the first memory for the city.
  /// 
  /// The [cityName] parameter specifies which city to update.
  static Future<void> _updateCityMemoryCount(String cityName) async {
    try {
      final cityDoc = _firestore.collection(_cityMemoriesCollection).doc(cityName);
      
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(cityDoc);
        
        if (snapshot.exists) {
          // Update existing city
          final data = snapshot.data()!;
          final currentCount = data['photoCount'] ?? 0;
          transaction.update(cityDoc, {
            'photoCount': currentCount + 1,
            'lastVisited': DateTime.now().toIso8601String(),
          });
        } else {
          // Create new city entry
          final cityMemory = CityMemory(
            cityName: cityName,
            photoCount: 1,
            lastVisited: DateTime.now(),
            thumbnailPath: 'assets/images/default_city.jpg',
          );
          transaction.set(cityDoc, cityMemory.toJson());
        }
      });
    } catch (e) {
      print('Error updating city memory count: $e');
    }
  }

  /// All memories for a specific city.
  /// 
  /// Retrieves memories from Firestore filtered by city name
  /// and ordered by date (most recent first).
  /// 
  /// The [cityName] parameter specifies which city's memories to load.
  /// 
  /// ```dart
  /// final parisMemories = await FirebaseService.getMemoriesForCity('Paris');
  /// print('Found ${parisMemories.length} memories in Paris');
  /// ```
  /// 
  /// Returns a list of [MemoryEntry] objects, or empty list if error occurs.
  static Future<List<MemoryEntry>> getMemoriesForCity(String cityName) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_memoriesCollection)
          .where('cityName', isEqualTo: cityName)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MemoryEntry.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading memories for city: $e');
      return [];
    }
  }

  /// All city memories from Firestore.
  /// 
  /// Retrieves all city memory records ordered by last visited date
  /// (most recently visited first).
  /// 
  /// ```dart
  /// final cities = await FirebaseService.getAllCityMemories();
  /// for (final city in cities) {
  ///   print('${city.cityName}: ${city.photoCount} photos');
  /// }
  /// ```
  /// 
  /// Returns a list of [CityMemory] objects, or empty list if error occurs.
  static Future<List<CityMemory>> getAllCityMemories() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_cityMemoriesCollection)
          .orderBy('lastVisited', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CityMemory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading city memories: $e');
      return [];
    }
  }

  /// Deletes a memory and all associated photos.
  /// 
  /// Removes the memory document from Firestore and deletes
  /// all associated photos from Firebase Storage.
  /// 
  /// The [memoryId] parameter identifies which memory to delete.
  /// 
  /// Throws [Exception] if the deletion fails.
  static Future<void> deleteMemory(String memoryId) async {
    try {
      // Delete from Firestore
      await _firestore.collection(_memoriesCollection).doc(memoryId).delete();

      // Delete photos from Storage
      await _deleteMemoryPhotos(memoryId);

      print('Memory deleted successfully: $memoryId');
    } catch (e) {
      print('Error deleting memory: $e');
      throw Exception('Failed to delete memory: $e');
    }
  }

  /// Deletes all photos for a specific memory from Firebase Storage.
  /// 
  /// Lists all files in the memory's photo folder and deletes them.
  /// This is a cleanup operation that runs when a memory is deleted.
  /// 
  /// The [memoryId] parameter identifies which memory's photos to delete.
  static Future<void> _deleteMemoryPhotos(String memoryId) async {
    try {
      final ListResult result = await _storage
          .ref()
          .child('memory_photos')
          .child(memoryId)
          .listAll();

      for (Reference ref in result.items) {
        await ref.delete();
      }
    } catch (e) {
      print('Error deleting memory photos: $e');
    }
  }

  /// Updates an existing memory in Firestore.
  /// 
  /// Updates the memory document with new data. Note that this
  /// method does not handle photo uploads - use [saveMemory] for
  /// memories with new photos.
  /// 
  /// The [memory] parameter contains the updated memory data.
  /// 
  /// Throws [Exception] if the update fails.
  static Future<void> updateMemory(MemoryEntry memory) async {
    try {
      await _firestore
          .collection(_memoriesCollection)
          .doc(memory.id)
          .update(memory.toJson());

      print('Memory updated successfully: ${memory.id}');
    } catch (e) {
      print('Error updating memory: $e');
      throw Exception('Failed to update memory: $e');
    }
  }
}
