import 'package:flutter/material.dart';
import 'car_controller.dart';
import 'car_model.dart';
import 'car_payment_screen.dart';

/// UI screen for browsing and selecting rental cars.
class CarRentalPage extends StatefulWidget {
  const CarRentalPage({super.key});

  @override
  State<CarRentalPage> createState() => _CarRentalPageState();
}

class _CarRentalPageState extends State<CarRentalPage> {
  /// Controller instance for retrieving car data.
  final CarController _controller = CarController();

  /// Selected pickup location.
  String? _from;

  /// Selected drop-off location.
  String? _to;

  /// Number of passengers traveling.
  int _passengers = 1;

  /// List of cars matching search filters.
  List<Car> _availableCars = [];

  /// Searches for cars that match the selected 'from' location
  /// and have enough seats for the chosen number of passengers.
  void _searchCars() {
    if (_from == null || _to == null) return;

    final allCars = _controller.getCarsByLocation(_from!);
    final filteredCars =
        allCars.where((car) => car.seats >= _passengers).toList();

    setState(() {
      _availableCars = filteredCars;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locations = _controller.getLocations();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Rentals"),
        backgroundColor: const Color(0xFF264653),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Search Cars",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            /// Pickup location selector
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'From'),
              value: _from,
              items: locations
                  .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                  .toList(),
              onChanged: (val) => setState(() => _from = val),
            ),

            /// Drop-off location selector
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'To'),
              value: _to,
              items: locations
                  .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                  .toList(),
              onChanged: (val) => setState(() => _to = val),
            ),
            const SizedBox(height: 10),

            /// Passenger selector
            Row(
              children: [
                const Text("Passengers:"),
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_passengers > 1) setState(() => _passengers--);
                    }),
                Text("$_passengers"),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() => _passengers++);
                    }),
              ],
            ),

            /// Search button
            ElevatedButton(
              onPressed: _searchCars,
              child: const Text("Search Available Cars"),
            ),
            const SizedBox(height: 20),

            const Text("Available Cars",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            /// Search results list
            Expanded(
              child: _availableCars.isEmpty
                  ? const Center(child: Text("No cars found."))
                  : ListView.builder(
                      itemCount: _availableCars.length,
                      itemBuilder: (_, index) {
                        final car = _availableCars[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.directions_car),
                            title: Text("${car.name} - ${car.type}"),
                            subtitle: Text(
                                "Seats: ${car.seats}, \$${car.pricePerDay}/day"),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CarPaymentScreen(
                                        car: car, passengers: _passengers),
                                  ),
                                );
                              },
                              child: const Text("Book Now"),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
