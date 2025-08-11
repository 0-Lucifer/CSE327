import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HotelHomePage.dart';
import 'listofhotels.dart';
<<<<<<< HEAD
import 'profile.dart';
import 'flight.dart';
import 'experiences.dart';
import 'TrainHomePage.dart';
import 'AuthScreen.dart';
import 'car_rental_page.dart';
=======
import 'profile.dart'; // Importing the ProfileScreen
import 'flight.dart'; // Importing the FlightScreen
import 'Experiences.dart';
import 'TrainHomePage.dart';
import 'AuthScreen.dart';
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
<<<<<<< HEAD
              Color(0xFF007E95),
=======
              Color(0xFF007E95), // Keep your background color
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
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
                    GestureDetector(
                      onTap: () {
<<<<<<< HEAD
=======
                        // Navigate to the ProfileScreen
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
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
                    Text(
                      'Tourify Dashboard',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AuthScreen()),
                        );
                      },
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
<<<<<<< HEAD
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
=======
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
<<<<<<< HEAD
                                builder: (context) => FlightScreen()),
=======
                              builder: (context) => FlightScreen(),
                            ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                          );
                        },
                        child: buildIconCard(Icons.flight, "Flights"),
                      ),
<<<<<<< HEAD
                      SizedBox(width: 10),
=======
                      SizedBox(width: 10), // Add spacing between cards
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
<<<<<<< HEAD
                                builder: (context) => HotelHomePage()),
=======
                              builder: (context) => HotelHomePage(),
                            ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                          );
                        },
                        child: buildIconCard(Icons.hotel, "Hotels"),
                      ),
                      SizedBox(width: 10),
<<<<<<< HEAD
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarRentalPage()),
                          );
                        },
                        child:
                            buildIconCard(Icons.directions_car, "Car Rentals"),
                      ),
                      SizedBox(width: 10),
                      buildIconCard(Icons.tour, "Tour Packages"),
=======
                      buildIconCard(Icons.directions_car, "Car Rentals"),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the TourPackagesScreen (uncomment if needed)
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => TourPackagesScreen(),
                          //   ),
                          // );
                        },
                        child: buildIconCard(Icons.tour, "Tour Packages"),
                      ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                    ],
                  ),
                ),
              ),

<<<<<<< HEAD
              // Second Row of Icons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
=======
              // Second Row for Experiences, Trains, Transfers, Travel Guides
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
<<<<<<< HEAD
                                builder: (context) => ExperienceScreen()),
=======
                              builder: (context) => ExperienceScreen(),
                            ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                          );
                        },
                        child: buildIconCard(Icons.explore, "Experiences"),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
<<<<<<< HEAD
                                builder: (context) => TrainHomePage()),
=======
                              builder: (context) => TrainHomePage(),
                            ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                          );
                        },
                        child: buildIconCard(Icons.train, "Train"),
                      ),
                      SizedBox(width: 10),
                      buildIconCard(Icons.airport_shuttle, "Transfers"),
                      SizedBox(width: 10),
<<<<<<< HEAD
                      buildIconCard(Icons.map, "Travel Guides"),
=======
                      GestureDetector(
                        onTap: () {},
                        child: buildIconCard(Icons.map, "Travel Guides"),
                      ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                    ],
                  ),
                ),
              ),

<<<<<<< HEAD
              // Additional Features
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
=======
              // Additional Features Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                child: Column(
                  children: [
                    buildFeatureCard(
                      icon: Icons.support_agent,
                      title: "Customer Support in Seconds",
                      description: "Get instant help with your bookings.",
                    ),
                    SizedBox(height: 10),
                    buildFeatureCard(
                      icon: Icons.verified_user,
                      title: "Travel Worry-free",
                      description:
<<<<<<< HEAD
                          "Enjoy a seamless and secure travel experience.",
=======
                      "Enjoy a seamless and secure travel experience.",
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                    ),
                    SizedBox(height: 10),
                    buildFeatureCard(
                      icon: Icons.discount,
                      title: "Exclusive Rewards & Discounts",
                      description: "Save big with exclusive deals and rewards.",
                    ),
                  ],
                ),
              ),

<<<<<<< HEAD
              // Popular Destinations
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
=======
              // Popular Destinations Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Where to next?",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildDestinationCard("Cox's Bazar", context),
                          buildDestinationCard("Teknaf", context),
                          buildDestinationCard("Bandarban", context),
                          buildDestinationCard("Sreemangal", context),
                          buildDestinationCard("Sajek", context),
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

<<<<<<< HEAD
  Widget buildIconCard(IconData icon, String title) {
    return Container(
      width: 70,
=======
  // Icon Card for Navigation Bar
  Widget buildIconCard(IconData icon, String title) {
    return Container(
      width: 70, // Fixed width to control the size
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
<<<<<<< HEAD
            radius: 25,
=======
            radius: 25, // Reduced size to fit better
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
            backgroundColor: Colors.white,
            child: Icon(icon, size: 25, color: Color(0xFF264653)),
          ),
          SizedBox(height: 5),
          Text(
            title,
<<<<<<< HEAD
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 11,
=======
            textAlign: TextAlign.center, // Center the text
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 11, // Reduced font size
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget buildFeatureCard(
      {required IconData icon,
      required String title,
      required String description}) {
=======
  // Feature Card for Additional Features
  Widget buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
    return Card(
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Color(0xFF264653)),
            SizedBox(width: 10),
<<<<<<< HEAD
            Expanded(
=======
            Expanded( // Use Expanded to prevent overflow in the description
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget buildDestinationCard(String destination, BuildContext context) {
    return GestureDetector(
      onTap: () {
=======
  // Destination Card for Popular Destinations
  Widget buildDestinationCard(String destination, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation logic for destinations
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(20),
<<<<<<< HEAD
              height: MediaQuery.of(context).size.height * 0.8,
=======
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
<<<<<<< HEAD
                          Navigator.of(context).pop();
=======
                          Navigator.of(context).pop(); // Close the bottom sheet
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: hotels[destination]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final hotel = hotels[destination]![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel["name"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
<<<<<<< HEAD
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
=======
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
                                    SizedBox(width: 5),
                                    Text(
                                      "${hotel["rating"]} (${hotel["reviews"]} reviews)",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
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
      },
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
<<<<<<< HEAD
}
=======
}
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
