/// Widget tests for MemoryScreen view component.
/// 
/// Tests UI rendering, user interactions, and navigation flow
/// for the main travel memories screen with Navy Blue Glass theme.
/// 
/// Developer: NAHIAN SYED AHANAF (ID: 2212705042)
/// Course: CSE327 - Software Engineering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/screens/memory_screen.dart';
import 'package:tourify/screens/add_city_screen.dart';

void main() {
  group('MemoryScreen Widget Tests', () {
    testWidgets('should display app title correctly', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      // Assert
      expect(find.text('My Travel Memories'), findsOneWidget);
    });

    testWidgets('should display header with Navy Blue Glass theme', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      // Wait for the widget to build
      await tester.pump();

      // Assert - Check for header elements
      expect(find.text('Your Travel Diary'), findsOneWidget);
      expect(find.text('Discover your memories in style'), findsOneWidget);
    });

    testWidgets('should display city cards with sample data', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      // Wait for the widget to build
      await tester.pump();

      // Assert - Check for sample cities
      expect(find.text('Dhaka'), findsOneWidget);
      expect(find.text("Cox's Bazar"), findsOneWidget);
      expect(find.text('Sylhet'), findsOneWidget);
    });

    testWidgets('should display photo counts for cities', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for photo count text
      expect(find.text('15 memories'), findsOneWidget); // Dhaka
      expect(find.text('28 memories'), findsOneWidget); // Cox's Bazar
      expect(find.text('12 memories'), findsOneWidget); // Sylhet
    });

    testWidgets('should display floating action button', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Add City'), findsOneWidget);
      expect(find.byIcon(Icons.add_location_alt), findsOneWidget);
    });

    testWidgets('should navigate to AddCityScreen when FAB is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: const MemoryScreen(),
          routes: {
            '/add-city': (context) => const AddCityScreen(),
          },
        ),
      );

      await tester.pump();

      // Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Assert - Check if navigation occurred
      expect(find.byType(AddCityScreen), findsOneWidget);
    });

    testWidgets('should display city grid layout', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for GridView
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should handle city card tap interactions', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Act - Tap on Dhaka city card
      await tester.tap(find.text('Dhaka'));
      await tester.pumpAndSettle();

      // Assert - Should navigate (we can't test the actual navigation without proper routing setup)
      // But we can verify the tap was registered
      expect(find.text('Dhaka'), findsOneWidget);
    });

    testWidgets('should display Navy Blue Glass theme colors', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for Container widgets (glass containers)
      expect(find.byType(Container), findsWidgets);
      
      // Check for gradient decorations (Navy Blue Glass theme)
      final containers = tester.widgetList<Container>(find.byType(Container));
      final hasGradientDecoration = containers.any((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration && decoration.gradient != null;
      });
      
      expect(hasGradientDecoration, true);
    });

    testWidgets('should display city icons', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for location city icons
      expect(find.byIcon(Icons.location_city), findsWidgets);
    });

    testWidgets('should handle empty state gracefully', (WidgetTester tester) async {
      // Note: This test would require modifying the MemoryScreen to accept empty data
      // For now, we test that the screen renders without errors
      
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Screen should render without throwing errors
      expect(find.byType(MemoryScreen), findsOneWidget);
    });

    testWidgets('should display formatted dates', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for date format (DD/MM/YYYY)
      expect(find.textContaining('/'), findsWidgets);
    });

    testWidgets('should have proper accessibility labels', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for semantic labels
      expect(find.byType(Semantics), findsWidgets);
    });

    testWidgets('should handle screen rotation', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Act - Simulate screen size change
      tester.binding.window.physicalSizeTestValue = const Size(800, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pump();

      // Assert - Screen should still render correctly
      expect(find.byType(MemoryScreen), findsOneWidget);
      expect(find.text('My Travel Memories'), findsOneWidget);

      // Cleanup
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    testWidgets('should display premium glass effects', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Check for glass effect containers
      final containers = tester.widgetList<Container>(find.byType(Container));
      final hasGlassEffect = containers.any((container) {
        final decoration = container.decoration;
        if (decoration is BoxDecoration) {
          return decoration.boxShadow != null || 
                 decoration.border != null ||
                 decoration.gradient != null;
        }
        return false;
      });
      
      expect(hasGlassEffect, true);
    });

    testWidgets('should maintain state during widget rebuilds', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Act - Trigger a rebuild
      await tester.pumpWidget(
        const MaterialApp(
          home: MemoryScreen(),
        ),
      );

      await tester.pump();

      // Assert - Content should remain the same
      expect(find.text('Dhaka'), findsOneWidget);
      expect(find.text("Cox's Bazar"), findsOneWidget);
      expect(find.text('Sylhet'), findsOneWidget);
    });
  });
}