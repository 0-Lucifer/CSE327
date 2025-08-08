/// Unit tests for MemoryEntry model class.
/// 
/// Tests data integrity, JSON serialization, and model validation
/// for the travel memory data structure.
/// 
/// Developer: NAHIAN SYED AHANAF (ID: 2212705042)
/// Course: CSE327 - Software Engineering

import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/models/memory_entry.dart';

void main() {
  group('MemoryEntry Model Tests', () {
    late MemoryEntry testMemory;
    late DateTime testDate;

    setUp(() {
      testDate = DateTime(2024, 1, 15, 10, 30);
      testMemory = MemoryEntry(
        id: 'test-memory-123',
        title: 'Beautiful Sunset at Dhaka',
        story: 'Had an amazing evening watching the sunset from the rooftop. The colors were absolutely breathtaking and the city looked magical.',
        date: testDate,
        photos: ['photo1.jpg', 'photo2.jpg', 'photo3.jpg'],
        cityName: 'Dhaka',
      );
    });

    test('should create MemoryEntry with valid data', () {
      // Assert
      expect(testMemory.id, 'test-memory-123');
      expect(testMemory.title, 'Beautiful Sunset at Dhaka');
      expect(testMemory.story, contains('amazing evening'));
      expect(testMemory.date, testDate);
      expect(testMemory.photos.length, 3);
      expect(testMemory.cityName, 'Dhaka');
    });

    test('should handle empty photos list', () {
      // Arrange
      final memoryWithoutPhotos = MemoryEntry(
        id: 'test-no-photos',
        title: 'Memory without photos',
        story: 'Just a story',
        date: DateTime.now(),
        photos: [],
        cityName: 'Sylhet',
      );

      // Assert
      expect(memoryWithoutPhotos.photos, isEmpty);
      expect(memoryWithoutPhotos.hasPhotos, false);
      expect(memoryWithoutPhotos.photoCount, 0);
    });

    test('should handle null cityName', () {
      // Arrange
      final memoryWithoutCity = MemoryEntry(
        id: 'test-no-city',
        title: 'Memory without city',
        story: 'A story without location',
        date: DateTime.now(),
        photos: ['photo1.jpg'],
      );

      // Assert
      expect(memoryWithoutCity.cityName, isNull);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = testMemory.toJson();

      // Assert
      expect(json['id'], 'test-memory-123');
      expect(json['title'], 'Beautiful Sunset at Dhaka');
      expect(json['story'], contains('amazing evening'));
      expect(json['date'], testDate.toIso8601String());
      expect(json['photos'], ['photo1.jpg', 'photo2.jpg', 'photo3.jpg']);
      expect(json['cityName'], 'Dhaka');
    });

    test('should create from JSON correctly', () {
      // Arrange
      final json = {
        'id': 'json-test-456',
        'title': 'JSON Test Memory',
        'story': 'This memory was created from JSON',
        'date': '2024-02-20T14:30:00.000Z',
        'photos': ['json_photo1.jpg', 'json_photo2.jpg'],
        'cityName': 'Cox\'s Bazar',
      };

      // Act
      final memory = MemoryEntry.fromJson(json);

      // Assert
      expect(memory.id, 'json-test-456');
      expect(memory.title, 'JSON Test Memory');
      expect(memory.story, 'This memory was created from JSON');
      expect(memory.photos, ['json_photo1.jpg', 'json_photo2.jpg']);
      expect(memory.cityName, 'Cox\'s Bazar');
    });

    test('should handle JSON with null cityName', () {
      // Arrange
      final json = {
        'id': 'json-null-city',
        'title': 'Memory with null city',
        'story': 'Test story',
        'date': '2024-01-01T00:00:00.000Z',
        'photos': [],
        'cityName': null,
      };

      // Act
      final memory = MemoryEntry.fromJson(json);

      // Assert
      expect(memory.cityName, isNull);
    });

    test('should create copy with updated values', () {
      // Act
      final updatedMemory = testMemory.copyWith(
        title: 'Updated Title',
        photos: ['new_photo.jpg'],
      );

      // Assert
      expect(updatedMemory.id, testMemory.id); // Unchanged
      expect(updatedMemory.title, 'Updated Title'); // Changed
      expect(updatedMemory.story, testMemory.story); // Unchanged
      expect(updatedMemory.photos, ['new_photo.jpg']); // Changed
      expect(updatedMemory.cityName, testMemory.cityName); // Unchanged
    });

    test('should calculate photo count correctly', () {
      // Assert
      expect(testMemory.photoCount, 3);
      
      // Test with empty photos
      final emptyMemory = testMemory.copyWith(photos: []);
      expect(emptyMemory.photoCount, 0);
    });

    test('should check if memory has photos', () {
      // Assert
      expect(testMemory.hasPhotos, true);
      
      // Test with empty photos
      final emptyMemory = testMemory.copyWith(photos: []);
      expect(emptyMemory.hasPhotos, false);
    });

    test('should format date correctly', () {
      // Act
      final formattedDate = testMemory.formattedDate;

      // Assert
      expect(formattedDate, contains('15/1/2024'));
    });

    test('should handle edge cases in JSON conversion', () {
      // Arrange - Memory with special characters
      final specialMemory = MemoryEntry(
        id: 'special-123',
        title: 'Memory with "quotes" and symbols!',
        story: 'Story with\nnewlines and\ttabs',
        date: DateTime(2024, 12, 31, 23, 59, 59),
        photos: [],
        cityName: 'City with spaces & symbols',
      );

      // Act
      final json = specialMemory.toJson();
      final recreatedMemory = MemoryEntry.fromJson(json);

      // Assert
      expect(recreatedMemory.title, specialMemory.title);
      expect(recreatedMemory.story, specialMemory.story);
      expect(recreatedMemory.cityName, specialMemory.cityName);
    });
  });
}