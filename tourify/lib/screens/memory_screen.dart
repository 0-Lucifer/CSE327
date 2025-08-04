/// Main user interface screens for travel memory management.
/// 
/// This library contains the primary screens for the Tourify app:
/// - Memory overview with city-based organization
/// - Premium glassmorphism UI components
/// - Navigation to detailed memory views
/// - Interactive city grid with photo counts
/// 
/// The [MemoryScreen] serves as the home page, providing an elegant
/// interface for users to browse and manage their travel memories.
library;

import 'package:flutter/material.dart';
import 'city_memory_detail_screen.dart';
import 'add_city_screen.dart';
import '../models/city_memory.dart';
import '../theme/app_theme.dart';

/// Main screen displaying the user's travel memories organized by city.
/// 
/// This screen serves as the home page of the Tourify app, showing
/// a grid of cities the user has visited with photo counts and
/// last visited dates. Users can tap on cities to view detailed
/// memories or add new cities to their collection.
class MemoryScreen extends StatefulWidget {
  /// Creates the main memory screen widget.
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

/// State class for the memory screen managing city memories and UI.
class _MemoryScreenState extends State<MemoryScreen> {
  /// List of city memories to display in the grid.
  /// 
  /// Contains sample data for demonstration. In a production app,
  /// this would be loaded from Firebase or local storage.
  final List<CityMemory> _cityMemories = [
    CityMemory(
      cityName: 'Dhaka',
      photoCount: 15,
      lastVisited: DateTime(2024, 12, 15),
      thumbnailPath: 'assets/images/dhaka_thumb.jpg',
    ),
    CityMemory(
      cityName: "Cox's Bazar",
      photoCount: 28,
      lastVisited: DateTime(2024, 11, 20),
      thumbnailPath: 'assets/images/coxs_bazar_thumb.jpg',
    ),
    CityMemory(
      cityName: 'Sylhet',
      photoCount: 12,
      lastVisited: DateTime(2024, 10, 5),
      thumbnailPath: 'assets/images/sylhet_thumb.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Travel Memories',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: AppTheme.premiumBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildPremiumHeader(),
                const SizedBox(height: 30),
                Expanded(
                  child: _cityMemories.isEmpty
                      ? _buildPremiumEmptyState()
                      : _buildPremiumCityGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildPremiumFAB(),
    );
  }

  /// Builds grid view of city memory cards
  Widget _buildCityGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _cityMemories.length,
      itemBuilder: (context, index) {
        final cityMemory = _cityMemories[index];
        return _buildCityCard(cityMemory);
      },
    );
  }

  /// Builds individual city memory card
  Widget _buildCityCard(CityMemory cityMemory) {
    return GestureDetector(
      onTap: () => _navigateToCityDetail(cityMemory),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.teal.shade300,
                      Colors.teal.shade600,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.location_city,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        cityMemory.cityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${cityMemory.photoCount} photos',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      _formatDate(cityMemory.lastVisited),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds empty state when no memories exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No memories yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start creating your travel diary!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCityDetatail screen
  void _navigateToCityDetail(CityMemory cityMemory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CityMemoryDetailScreen(cityMemory: cityMemory),
      ),
    );
  }

  /// Handles adding new city to travel collection
  void _addNewMemory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCityScreen(),
      ),
    ).then((result) {
      if (result != null && result is CityMemory) {
        setState(() {
          _cityMemories.add(result);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.cityName} added to your travel collection!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  Widget _buildPremiumHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.glassContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.goldAccent, AppTheme.goldAccent.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Premium Travel Diary',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primaryNavy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Discover your memories in style',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryNavy.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCityGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: _cityMemories.length,
      itemBuilder: (context, index) {
        final cityMemory = _cityMemories[index];
        return _buildPremiumCityCard(cityMemory);
      },
    );
  }

  Widget _buildPremiumCityCard(CityMemory cityMemory) {
    return GestureDetector(
      onTap: () => _navigateToCityDetail(cityMemory),
      child: Container(
        decoration: AppTheme.glassContainer,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: AppTheme.navyGradient,
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.location_city,
                        size: 48,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.goldAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${cityMemory.photoCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        cityMemory.cityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryNavy,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cityMemory.photoCount} memories',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.primaryNavy.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      _formatDate(cityMemory.lastVisited),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.primaryNavy.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: AppTheme.glassContainer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryNavy.withOpacity(0.1),
                    AppTheme.lightNavy.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.explore,
                size: 64,
                color: AppTheme.primaryNavy.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start Your Journey',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryNavy,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first travel destination\nand create beautiful memories',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryNavy.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryNavy,
            AppTheme.lightNavy,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: _addNewMemory,
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: const Icon(Icons.add_location_alt, color: Colors.white),
        label: const Text(
          'Add City',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// Formats date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}