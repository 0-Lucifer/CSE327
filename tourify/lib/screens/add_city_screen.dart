import 'package:flutter/material.dart';
import '../models/city_memory.dart';
import '../theme/app_theme.dart';

/// Add New City Screen - Allows users to add a new travel destination
/// Users can add any city from around the world to their memory collection
class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  
  bool _isSaving = false;

  @override
  void dispose() {
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Add New Destination',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: AppTheme.goldAccentGradient,
            child: TextButton(
              onPressed: _isSaving ? null : _saveCity,
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.premiumBackground,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildPremiumHeader(),
                  const SizedBox(height: 32),
                  _buildPremiumCityField(),
                  const SizedBox(height: 20),
                  _buildPremiumCountryField(),
                  const SizedBox(height: 32),
                  _buildPremiumExampleSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds premium header section
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
                decoration: AppTheme.navyGradient,
                child: const Icon(
                  Icons.add_location_alt,
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
                      'Add New Destination',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primaryNavy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Expand your travel collection',
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

  /// Builds premium city input field
  Widget _buildPremiumCityField() {
    return Container(
      decoration: AppTheme.glassContainer,
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: _cityController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.primaryNavy,
        ),
        decoration: InputDecoration(
          labelText: 'City Name',
          hintText: 'e.g., Paris, Tokyo, New York',
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryNavy, AppTheme.lightNavy],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.location_city, color: Colors.white, size: 20),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a city name';
          }
          return null;
        },
        textCapitalization: TextCapitalization.words,
      ),
    );
  }

  /// Builds premium country input field
  Widget _buildPremiumCountryField() {
    return Container(
      decoration: AppTheme.glassContainer,
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: _countryController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.primaryNavy,
        ),
        decoration: InputDecoration(
          labelText: 'Country',
          hintText: 'e.g., France, Japan, USA',
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryNavy, AppTheme.lightNavy],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.public, color: Colors.white, size: 20),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a country name';
          }
          return null;
        },
        textCapitalization: TextCapitalization.words,
      ),
    );
  }

  /// Builds premium example section
  Widget _buildPremiumExampleSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.glassContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: AppTheme.goldAccentGradient,
                child: const Icon(Icons.explore, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Popular Destinations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPremiumExampleChips(),
        ],
      ),
    );
  }

  /// Builds premium example destination chips
  Widget _buildPremiumExampleChips() {
    final examples = [
      'Paris, France',
      'Tokyo, Japan',
      'New York, USA',
      'London, UK',
      'Dubai, UAE',
      'Bangkok, Thailand',
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: examples.map((example) {
        final parts = example.split(', ');
        return GestureDetector(
          onTap: () => _fillExample(parts[0], parts[1]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryNavy.withOpacity(0.1),
                  AppTheme.lightNavy.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryNavy.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              example,
              style: TextStyle(
                color: AppTheme.primaryNavy,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Fills form with example data
  void _fillExample(String city, String country) {
    setState(() {
      _cityController.text = city;
      _countryController.text = country;
    });
  }

  /// Saves the new city
  Future<void> _saveCity() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Create new city memory
      final cityName = '${_cityController.text.trim()}, ${_countryController.text.trim()}';
      
      final newCity = CityMemory(
        cityName: cityName,
        photoCount: 0,
        lastVisited: DateTime.now(),
        thumbnailPath: 'assets/images/default_city.jpg',
      );

      // TODO: Save to Firebase
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$cityName added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Return the new city to the previous screen
        Navigator.pop(context, newCity);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add city: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}