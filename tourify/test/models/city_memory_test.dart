/// Unit tests for CityMemory model class.
/// 
/// Tests city-based memory aggregation, JSON serialization,
/// and data validation for travel destination management.
/// 
/// Developer: NAHIAN SYED AHANAF (ID: 2212705042)
/// Course: CSE327 - Software Engineering

import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/models/city_memory.dart';

void main() {
  group('CityMemory Model Tests', () {
    late CityMemory testCityMemory;
    late DateTime testDate;

    setUp(() {
      testDate = DateTime(2024, 1, 15, 10, 30);
      testCityMemory = CityMemory(
        id: 'city-dhaka-123',
        cityName: 'Dhaka',
        photoCount: 25,
        lastVisited: testDate,
        thumbnailPath: 'assets/images/dhaka_thumb.jpg',
      );
    });

    test('should create CityMemory with valid data', () {
      // Assert
      expect(testCityMemory.id, 'city-dhaka-123');
      expect(testCityMemory.cityName, 'Dhaka');
      expect(testCityMemory.photoCount, 25);
      expect(testCityMemory.lastVisited, testDate);
      expect(testCityMemory.thumbnailPath, 'assets/images/dhaka_thumb.jpg');
    });

    test('should generate unique ID when not provided', () {
      // Arrange & Act
      final cityMemory1 = CityMemory(
        cityName: 'Sylhet',
        photoCount: 10,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/sylhet.jpg',
      );

      final cityMemory2 = CityMemory(
        cityName: 'Cox\'s Bazar',
        photoCount: 15,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/coxs_bazar.jpg',
      );

      // Assert
      expect(cityMemory1.id, isNotEmpty);
      expect(cityMemory2.id, isNotEmpty);
      expect(cityMemory1.id, isNot(equals(cityMemory2.id)));
    });

    test('should handle zero photo count', () {
      // Arrange
      final newCity = CityMemory(
        cityName: 'New City',
        photoCount: 0,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/default.jpg',
      );

      // Assert
      expect(newCity.photoCount, 0);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = testCityMemory.toJson();

      // Assert
      expect(json['id'], 'city-dhaka-123');
      expect(json['cityName'], 'Dhaka');
      expect(json['photoCount'], 25);
      expect(json['lastVisited'], testDate.toIso8601String());
      expect(json['thumbnailPath'], 'assets/images/dhaka_thumb.jpg');
    });

    test('should create from JSON correctly', () {
      // Arrange
      final json = {
        'id': 'json-city-456',
        'cityName': 'Chittagong',
        'photoCount': 18,
        'lastVisited': '2024-03-10T16:45:00.000Z',
        'thumbnailPath': 'assets/images/chittagong.jpg',
      };

      // Act
      final cityMemory = CityMemory.fromJson(json);

      // Assert
      expect(cityMemory.id, 'json-city-456');
      expect(cityMemory.cityName, 'Chittagong');
      expect(cityMemory.photoCount, 18);
      expect(cityMemory.thumbnailPath, 'assets/images/chittagong.jpg');
    });

    test('should create copy with updated values', () {
      // Act
      final updatedCity = testCityMemory.copyWith(
        photoCount: 30,
        lastVisited: DateTime(2024, 2, 1),
      );

      // Assert
      expect(updatedCity.id, testCityMemory.id); // Unchanged
      expect(updatedCity.cityName, testCityMemory.cityName); // Unchanged
      expect(updatedCity.photoCount, 30); // Changed
      expect(updatedCity.lastVisited, DateTime(2024, 2, 1)); // Changed
      expect(updatedCity.thumbnailPath, testCityMemory.thumbnailPath); // Unchanged
    });

    test('should handle city names with special characters', () {
      // Arrange
      final specialCity = CityMemory(
        cityName: 'Cox\'s Bazar & Beach Resort',
        photoCount: 42,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/special_city.jpg',
      );

      // Act
      final json = specialCity.toJson();
      final recreatedCity = CityMemory.fromJson(json);

      // Assert
      expect(recreatedCity.cityName, 'Cox\'s Bazar & Beach Resort');
    });

    test('should handle large photo counts', () {
      // Arrange
      final popularCity = CityMemory(
        cityName: 'Popular Destination',
        photoCount: 9999,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/popular.jpg',
      );

      // Assert
      expect(popularCity.photoCount, 9999);
    });

    test('should maintain data integrity through JSON round trip', () {
      // Act
      final json = testCityMemory.toJson();
      final recreatedCity = CityMemory.fromJson(json);

      // Assert
      expect(recreatedCity.id, testCityMemory.id);
      expect(recreatedCity.cityName, testCityMemory.cityName);
      expect(recreatedCity.photoCount, testCityMemory.photoCount);
      expect(recreatedCity.lastVisited, testCityMemory.lastVisited);
      expect(recreatedCity.thumbnailPath, testCityMemory.thumbnailPath);
    });

    test('should handle different date formats', () {
      // Arrange
      final pastDate = DateTime(2020, 6, 15);
      final futureDate = DateTime(2025, 12, 31);

      final pastCity = testCityMemory.copyWith(lastVisited: pastDate);
      final futureCity = testCityMemory.copyWith(lastVisited: futureDate);

      // Act & Assert
      expect(pastCity.lastVisited.year, 2020);
      expect(futureCity.lastVisited.year, 2025);
    });

    test('should validate required fields are not null', () {
      // Assert
      expect(testCityMemory.id, isNotNull);
      expect(testCityMemory.cityName, isNotNull);
      expect(testCityMemory.photoCount, isNotNull);
      expect(testCityMemory.lastVisited, isNotNull);
      expect(testCityMemory.thumbnailPath, isNotNull);
    });
  });
}