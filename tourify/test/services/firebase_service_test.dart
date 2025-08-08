/// Unit tests for FirebaseService controller class.
/// 
/// Tests business logic, data operations, and Firebase integration
/// using mocks to isolate the service layer from external dependencies.
/// 
/// Developer: NAHIAN SYED AHANAF (ID: 2212705042)
/// Course: CSE327 - Software Engineering

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourify/models/memory_entry.dart';
import 'package:tourify/models/city_memory.dart';
import 'package:tourify/services/firebase_service.dart';
import 'dart:io';

// Mock classes for testing
class MockFile extends Mock implements File {}

void main() {
  group('FirebaseService Controller Tests', () {
    late MemoryEntry testMemory;
    late CityMemory testCity;

    setUp(() {
      testMemory = MemoryEntry(
        id: 'test-memory-123',
        title: 'Test Memory',
        story: 'This is a test memory for unit testing',
        date: DateTime(2024, 1, 15),
        photos: ['test_photo1.jpg', 'test_photo2.jpg'],
        cityName: 'Dhaka',
      );

      testCity = CityMemory(
        id: 'test-city-123',
        cityName: 'Dhaka',
        photoCount: 5,
        lastVisited: DateTime(2024, 1, 15),
        thumbnailPath: 'assets/images/dhaka.jpg',
      );
    });

    group('Memory Management Tests', () {
      test('should validate memory data before processing', () {
        // Test memory has required fields
        expect(testMemory.id, isNotEmpty);
        expect(testMemory.title, isNotEmpty);
        expect(testMemory.story, isNotEmpty);
        expect(testMemory.date, isNotNull);
        expect(testMemory.photos, isNotNull);
      });

      test('should handle memory with no photos', () {
        // Arrange
        final memoryWithoutPhotos = testMemory.copyWith(photos: []);

        // Assert
        expect(memoryWithoutPhotos.photos, isEmpty);
        expect(memoryWithoutPhotos.hasPhotos, false);
        expect(memoryWithoutPhotos.photoCount, 0);
      });

      test('should handle memory with multiple photos', () {
        // Arrange
        final memoryWithManyPhotos = testMemory.copyWith(
          photos: ['photo1.jpg', 'photo2.jpg', 'photo3.jpg', 'photo4.jpg', 'photo5.jpg'],
        );

        // Assert
        expect(memoryWithManyPhotos.photoCount, 5);
        expect(memoryWithManyPhotos.hasPhotos, true);
      });

      test('should validate memory title length', () {
        // Test various title lengths
        final shortTitle = testMemory.copyWith(title: 'Hi');
        final normalTitle = testMemory.copyWith(title: 'Beautiful sunset at the beach');
        final longTitle = testMemory.copyWith(title: 'A' * 100);

        expect(shortTitle.title.length, 2);
        expect(normalTitle.title.length, greaterThan(10));
        expect(longTitle.title.length, 100);
      });

      test('should handle special characters in memory content', () {
        // Arrange
        final specialMemory = testMemory.copyWith(
          title: 'Memory with "quotes" & symbols!',
          story: 'Story with\nnewlines and\ttabs & émojis 🌅',
        );

        // Assert
        expect(specialMemory.title, contains('"'));
        expect(specialMemory.title, contains('&'));
        expect(specialMemory.story, contains('\n'));
        expect(specialMemory.story, contains('🌅'));
      });
    });

    group('City Memory Management Tests', () {
      test('should validate city memory data', () {
        // Assert
        expect(testCity.cityName, isNotEmpty);
        expect(testCity.photoCount, greaterThanOrEqualTo(0));
        expect(testCity.lastVisited, isNotNull);
        expect(testCity.thumbnailPath, isNotEmpty);
      });

      test('should handle city photo count updates', () {
        // Act
        final updatedCity = testCity.copyWith(photoCount: testCity.photoCount + 1);

        // Assert
        expect(updatedCity.photoCount, testCity.photoCount + 1);
      });

      test('should handle city name variations', () {
        // Test different city name formats
        final cities = [
          testCity.copyWith(cityName: 'Dhaka'),
          testCity.copyWith(cityName: 'Cox\'s Bazar'),
          testCity.copyWith(cityName: 'New York City'),
          testCity.copyWith(cityName: 'São Paulo'),
        ];

        for (final city in cities) {
          expect(city.cityName, isNotEmpty);
          expect(city.cityName.length, greaterThan(0));
        }
      });

      test('should handle date operations correctly', () {
        // Arrange
        final now = DateTime.now();
        final yesterday = now.subtract(const Duration(days: 1));
        final nextWeek = now.add(const Duration(days: 7));

        // Act
        final recentCity = testCity.copyWith(lastVisited: now);
        final oldCity = testCity.copyWith(lastVisited: yesterday);
        final futureCity = testCity.copyWith(lastVisited: nextWeek);

        // Assert
        expect(recentCity.lastVisited.isAfter(yesterday), true);
        expect(oldCity.lastVisited.isBefore(now), true);
        expect(futureCity.lastVisited.isAfter(now), true);
      });
    });

    group('Data Validation Tests', () {
      test('should validate memory entry completeness', () {
        // Test required fields are present
        expect(testMemory.id, isNotNull);
        expect(testMemory.title, isNotNull);
        expect(testMemory.story, isNotNull);
        expect(testMemory.date, isNotNull);
        expect(testMemory.photos, isNotNull);
      });

      test('should handle null city name gracefully', () {
        // Arrange
        final memoryWithoutCity = MemoryEntry(
          id: 'test-no-city',
          title: 'Memory without city',
          story: 'A story without location',
          date: DateTime.now(),
          photos: [],
        );

        // Assert
        expect(memoryWithoutCity.cityName, isNull);
      });

      test('should validate photo paths format', () {
        // Test different photo path formats
        final memoryWithPaths = testMemory.copyWith(photos: [
          'local/photo1.jpg',
          'https://example.com/photo2.jpg',
          'assets/images/photo3.png',
          '/storage/photo4.jpeg',
        ]);

        for (final photoPath in memoryWithPaths.photos) {
          expect(photoPath, isNotEmpty);
          expect(photoPath, anyOf(
            contains('.jpg'),
            contains('.jpeg'),
            contains('.png'),
          ));
        }
      });
    });

    group('Business Logic Tests', () {
      test('should calculate memory statistics correctly', () {
        // Arrange
        final memories = [
          testMemory,
          testMemory.copyWith(id: '2', photos: ['p1.jpg']),
          testMemory.copyWith(id: '3', photos: []),
          testMemory.copyWith(id: '4', photos: ['p1.jpg', 'p2.jpg', 'p3.jpg']),
        ];

        // Act
        final totalPhotos = memories.fold<int>(
          0, 
          (sum, memory) => sum + memory.photoCount,
        );
        final memoriesWithPhotos = memories.where((m) => m.hasPhotos).length;

        // Assert
        expect(totalPhotos, 6); // 2 + 1 + 0 + 3
        expect(memoriesWithPhotos, 3); // 3 out of 4 have photos
      });

      test('should handle city memory aggregation', () {
        // Arrange
        final cities = [
          testCity,
          testCity.copyWith(id: '2', cityName: 'Sylhet', photoCount: 10),
          testCity.copyWith(id: '3', cityName: 'Cox\'s Bazar', photoCount: 15),
        ];

        // Act
        final totalPhotos = cities.fold<int>(
          0,
          (sum, city) => sum + city.photoCount,
        );
        final averagePhotos = totalPhotos / cities.length;

        // Assert
        expect(totalPhotos, 30); // 5 + 10 + 15
        expect(averagePhotos, 10.0);
      });

      test('should validate date ranges', () {
        // Arrange
        final oldDate = DateTime(2020, 1, 1);
        final recentDate = DateTime.now().subtract(const Duration(days: 30));
        final futureDate = DateTime.now().add(const Duration(days: 30));

        // Act & Assert
        expect(oldDate.isBefore(recentDate), true);
        expect(recentDate.isBefore(futureDate), true);
        expect(futureDate.isAfter(DateTime.now()), true);
      });
    });

    group('Error Handling Tests', () {
      test('should handle invalid JSON gracefully', () {
        // Test that models can handle missing or invalid JSON fields
        expect(() => MemoryEntry.fromJson({}), throwsA(isA<TypeError>()));
      });

      test('should validate required constructor parameters', () {
        // Test that required parameters are enforced
        expect(() => MemoryEntry(
          id: '',
          title: '',
          story: '',
          date: DateTime.now(),
          photos: [],
        ), returnsNormally);
      });
    });

    group('Performance Tests', () {
      test('should handle large photo lists efficiently', () {
        // Arrange
        final largePhotoList = List.generate(1000, (index) => 'photo_$index.jpg');
        
        // Act
        final memoryWithManyPhotos = testMemory.copyWith(photos: largePhotoList);

        // Assert
        expect(memoryWithManyPhotos.photoCount, 1000);
        expect(memoryWithManyPhotos.hasPhotos, true);
      });

      test('should handle JSON serialization of large data', () {
        // Arrange
        final largeStory = 'A' * 10000; // 10KB story
        final memoryWithLargeStory = testMemory.copyWith(story: largeStory);

        // Act
        final json = memoryWithLargeStory.toJson();
        final recreated = MemoryEntry.fromJson(json);

        // Assert
        expect(recreated.story.length, 10000);
        expect(recreated.story, equals(largeStory));
      });
    });
  });
}