import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HotelHomePage.dart';
import 'listofhotels.dart';
import 'profile.dart'; // Importing the ProfileScreen for user profile navigation
import 'tourpackages.dart'; // Importing the TourPackagesScreen for tour package navigation
import 'TravelGuides.dart'; // Importing the TravelGuidesScreen for travel guides navigation
import 'Rewards&Discounts.dart'; // Importing the RewardsDiscountsScreen for rewards navigation
import 'customersupport.dart'; // Importing the CustomerSupportScreen for support navigation
import 'experiences.dart';
import 'flight.dart'; // Importing the FlightScreen for flight search navigation
import 'TrainHomePage.dart';
import 'AuthScreen.dart';

// M (Model) - Data and business logic
// This section contains the data structures, state management, and business logic.
// - Hotel data structure for popular destinations.
// - Static data for hotels imported from listofhotels.dart.
class DashboardModel {
  /// Static map of hotel data for various destinations, sourced from listofhotels.dart.
  static final Map<String, List<Map<String, dynamic>>> hotels = HotelList.hotels;
}

// C (Controller) - Interaction logic between Model and View
// This section handles the interaction logic, including navigation and event handling.
// - Navigation methods for various screens.
// - Logic for showing hotel details in a modal bottom sheet.
class DashboardController {
  /// Build context for navigation and UI interactions.
  final BuildContext context;

  /// Creates a DashboardController with the given context.
  ///
  /// [context] The build context for navigation and UI interactions.
  DashboardController(this.context);

  /// Navigates to the ProfileScreen.
  void navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  /// Navigates to the AuthScreen, replacing the current screen.
  void navigateToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  /// Navigates to the FlightScreen for flight search.
  void navigateToFlight() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FlightScreen()),
    );
  }

  /// Navigates to the HotelHomePage for hotel search.
  void navigateToHotel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HotelHomePage()),
    );
  }

  /// Navigates to the TourPackagesScreen for tour package exploration.
  void navigateToTourPackages() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TourPackagesScreen()),
    );
  }

  /// Navigates to the ExperienceScreen for experience exploration.
  void navigateToExperience() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExperienceScreen()),
    );
  }

  /// Navigates to the TrainHomePage for train search.
  void navigateToTrain() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainHomePage()),
    );
  }

  /// Navigates to the TravelGuidesScreen for travel guides.
  void navigateToTravelGuides() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TravelGuidesScreen()),
    );
  }

  /// Navigates to the CustomerSupportScreen for customer support.
  void navigateToCustomerSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerSupportScreen()),
    );
  }

  /// Navigates to the RewardsDiscountsScreen for rewards and discounts.
  void navigateToRewardsDiscounts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RewardsDiscountsScreen()),
    );
  }

  /// Displays a modal bottom sheet with hotel details for the specified destination.
  ///
  /// [destination] The destination for which to show hotel details.
  void showHotelDetails(String destination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with destination name and back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hotels in $destination",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFF264653)),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              // List of hotels for the destination
              Expanded(
                child: ListView.builder(
                  itemCount: DashboardModel.hotels[destination]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final hotel = DashboardModel.hotels[destination]![index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hotel name
                            Text(
                              hotel["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            // Hotel rating and reviews
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${hotel["rating"]} (${hotel["reviews"]} reviews)",
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            // Hotel price and discount
                            Text(
                              "Price: ${hotel["price"]} | ${hotel["discount"]}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// V (View) - UI representation
// This section defines the UI components and layout.
// - Scaffold with gradient background for visual appeal.
// - Navigation bar, search bar, icon menus, feature cards, and destination cards.
// - Layout for the dashboard interface.
class DashboardScreen extends StatelessWidget {
  /// Creates the dashboard screen widget.
  @override
  Widget build(BuildContext context) {
    // Initialize controller in build
    DashboardController controller = DashboardController(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF007E95),
              Color(0xFF004D65),
              Color(0xFF003653),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Navigation Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile navigation button
                    GestureDetector(
                      onTap: controller.navigateToProfile,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF003B53),
                          child: Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Dashboard title
                    Text(
                      'Tourify Dashboard',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Logout button
                    GestureDetector(
                      onTap: controller.navigateToAuth,
                      child: Icon(Icons.logout, color: Colors.white, size: 28),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Where to?",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Color(0xFF264653)),
                    ),
                  ),
                ),
              ),

              // Icon Menu (Flights, Hotels, Car Rentals, etc.)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Flights navigation
                    GestureDetector(
                      onTap: controller.navigateToFlight,
                      child: buildIconCard(Icons.flight, "Flights"),
                    ),
                    // Hotels navigation
                    GestureDetector(
                      onTap: controller.navigateToHotel,
                      child: buildIconCard(Icons.hotel, "Hotels"),
                    ),
                    // Car Rentals (not implemented)
                    buildIconCard(Icons.directions_car, "Car Rentals"),
                    // Tour Packages navigation
                    GestureDetector(
                      onTap: controller.navigateToTourPackages,
                      child: buildIconCard(Icons.tour, "Tour Packages"),
                    ),
                  ],
                ),
              ),

              // Second Row for Experiences, Trains, Transfers, Travel Guides
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Experiences navigation
                    GestureDetector(
                      onTap: controller.navigateToExperience,
                      child: buildIconCard(Icons.explore, "Experiences"),
                    ),
                    // Train navigation
                    GestureDetector(
                      onTap: controller.navigateToTrain,
                      child: buildIconCard(Icons.train, "Train"),
                    ),
                    // Transfers (not implemented)
                    buildIconCard(Icons.airport_shuttle, "Transfers"),
                    // Travel Guides navigation
                    GestureDetector(
                      onTap: controller.navigateToTravelGuides,
                      child: buildIconCard(Icons.map, "Travel Guides"),
                    ),
                  ],
                ),
              ),

              // Additional Features Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    // Customer Support navigation
                    GestureDetector(
                      onTap: controller.navigateToCustomerSupport,
                      child: buildFeatureCard(
                        icon: Icons.support_agent,
                        title: "Customer Support in Seconds",
                        description: "Get instant help with your bookings.",
                      ),
                    ),
                    SizedBox(height: 20),
                    // Travel Worry-free card
                    buildFeatureCard(
                      icon: Icons.verified_user,
                      title: "Travel Worry-free",
                      description: "Enjoy a seamless travel experience.",
                    ),
                    SizedBox(height: 20),
                    // Rewards & Discounts navigation
                    GestureDetector(
                      onTap: controller.navigateToRewardsDiscounts,
                      child: buildFeatureCard(
                        icon: Icons.discount,
                        title: "Exclusive Rewards & Discounts",
                        description: "Save with exclusive deals and rewards.",
                      ),
                    ),
                  ],
                ),
              ),

              // Popular Destinations Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    Text(
                      "Where to next?",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Horizontal scrollable destination cards
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildDestinationCard("Cox's Bazar", controller),
                          buildDestinationCard("Teknaf", controller),
                          buildDestinationCard("Bandarban", controller),
                          buildDestinationCard("Sreemangal", controller),
                          buildDestinationCard("Sajek", controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds an icon card for the navigation menu.
  ///
  /// [icon] The icon to display in the card.
  /// [title] The title text below the icon.
  Widget buildIconCard(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 30, color: Color(0xFF264653)),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Builds a feature card for additional features section.
  ///
  /// [icon] The icon to display in the card.
  /// [title] The title of the feature.
  /// [description] The description text for the feature.
  Widget buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Color(0xFF264653)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a destination card for the popular destinations section.
  ///
  /// [destination] The name of the destination.
  /// [controller] The DashboardController to handle interactions.
  Widget buildDestinationCard(String destination, DashboardController controller) {
    return GestureDetector(
      onTap: () => controller.showHotelDetails(destination),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Chip(
          label: Text(
            destination,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: Color(0xFF264653),
        ),
      ),
    );
  }
}