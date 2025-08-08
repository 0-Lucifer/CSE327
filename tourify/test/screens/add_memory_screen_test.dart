/// Widget tests for AddMemoryScreen view component.
/// 
/// Tests form validation, photo picker integration, and Navy Blue Glass
/// theme rendering for the memory creation interface.
/// 
/// Developer: NAHIAN SYED AHANAF (ID: 2212705042)
/// Course: CSE327 - Software Engineering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/screens/add_memory_screen.dart';

void main() {
  group('AddMemoryScreen Widget Tests', () {
    const testCityName = 'Dhaka';

    testWidgets('should display screen title with city name', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      // Assert
      expect(find.text('Add Memory'), findsOneWidget);
    });

    testWidgets('should display Navy Blue Glass header', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Create New Memory'), findsOneWidget);
      expect(find.text('For $testCityName'), findsOneWidget);
    });

    testWidgets('should display title input field', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Memory Title'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('should display story input field', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Your Story'), findsOneWidget);
    });

    testWidgets('should display photo section', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Photos (0)'), findsOneWidget);
      expect(find.text('No photos added yet'), findsOneWidget);
    });

    testWidgets('should display camera and gallery buttons', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Camera'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
      expect(find.byIcon(Icons.photo_library), findsOneWidget);
    });

    testWidgets('should display save button in app bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('SAVE'), findsOneWidget);
    });

    testWidgets('should handle title input', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act
      final titleField = find.byType(TextField).first;
      await tester.enterText(titleField, 'Beautiful Sunset');
      await tester.pump();

      // Assert
      expect(find.text('Beautiful Sunset'), findsOneWidget);
    });

    testWidgets('should handle story input', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act
      final storyField = find.byType(TextField).last;
      await tester.enterText(storyField, 'This was an amazing experience in Dhaka.');
      await tester.pump();

      // Assert
      expect(find.text('This was an amazing experience in Dhaka.'), findsOneWidget);
    });

    testWidgets('should display Navy Blue Glass theme containers', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert - Check for glass containers
      final containers = tester.widgetList<Container>(find.byType(Container));
      final hasGlassEffect = containers.any((container) {
        final decoration = container.decoration;
        if (decoration is BoxDecoration) {
          return decoration.gradient != null || 
                 decoration.border != null ||
                 decoration.boxShadow != null;
        }
        return false;
      });
      
      expect(hasGlassEffect, true);
    });

    testWidgets('should display gold accent icons', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert - Check for icons with gold background
      expect(find.byIcon(Icons.add_photo_alternate), findsOneWidget);
      expect(find.byIcon(Icons.title), findsOneWidget);
      expect(find.byIcon(Icons.edit_note), findsOneWidget);
      expect(find.byIcon(Icons.photo_library), findsOneWidget);
    });

    testWidgets('should handle camera button tap', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act
      await tester.tap(find.text('Camera'));
      await tester.pump();

      // Assert - Button should be tappable (no exception thrown)
      expect(find.text('Camera'), findsOneWidget);
    });

    testWidgets('should handle gallery button tap', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act
      await tester.tap(find.text('Gallery'));
      await tester.pump();

      // Assert - Button should be tappable (no exception thrown)
      expect(find.text('Gallery'), findsOneWidget);
    });

    testWidgets('should display proper hint texts', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.textContaining('e.g., Beautiful Sunset at $testCityName'), findsOneWidget);
      expect(find.textContaining('Write about your experience in $testCityName'), findsOneWidget);
    });

    testWidgets('should handle different city names', (WidgetTester tester) async {
      // Test with different city names
      const cities = ['Cox\'s Bazar', 'Sylhet', 'Chittagong'];
      
      for (final city in cities) {
        // Arrange & Act
        await tester.pumpWidget(
          MaterialApp(
            home: AddMemoryScreen(cityName: city),
          ),
        );

        await tester.pump();

        // Assert
        expect(find.text('For $city'), findsOneWidget);
      }
    });

    testWidgets('should maintain scroll functionality', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act - Try to scroll
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pump();

      // Assert - Should not throw exception
      expect(find.byType(AddMemoryScreen), findsOneWidget);
    });

    testWidgets('should display gradient background', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert - Check for gradient background
      final containers = tester.widgetList<Container>(find.byType(Container));
      final hasGradientBackground = containers.any((container) {
        final decoration = container.decoration;
        if (decoration is BoxDecoration && decoration.gradient != null) {
          final gradient = decoration.gradient as LinearGradient;
          return gradient.colors.isNotEmpty;
        }
        return false;
      });
      
      expect(hasGradientBackground, true);
    });

    testWidgets('should handle form validation states', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act - Try to save without filling fields
      await tester.tap(find.text('SAVE'));
      await tester.pump();

      // Assert - Form should handle validation (no crash)
      expect(find.byType(AddMemoryScreen), findsOneWidget);
    });

    testWidgets('should display proper spacing between elements', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Assert - Check for SizedBox widgets (spacing)
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('should handle keyboard appearance', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AddMemoryScreen(cityName: testCityName),
        ),
      );

      await tester.pump();

      // Act - Focus on text field
      await tester.tap(find.byType(TextField).first);
      await tester.pump();

      // Assert - Should handle focus without issues
      expect(find.byType(AddMemoryScreen), findsOneWidget);
    });
  });
}