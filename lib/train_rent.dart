import 'package:flutter/material.dart';
import 'train_controller.dart';
import 'train_model.dart';
import 'train_payment.dart';

/// Train Booking — View (Search & List Available Trains)
///
/// This screen allows users to select origin, destination, passenger count,
/// and see a list of available trains that match their criteria.
/// It follows the MVC pattern: this is the **View** layer that uses
/// [TrainController] to retrieve data and [Train] model to display it.
class TrainRent extends StatefulWidget {
  const TrainRent({super.key});

  @override
  State<TrainRent> createState() => _TrainRentState();
}

class _TrainRentState extends State<TrainRent> {
  /// Controller to handle train-related data retrieval
  final TrainController _controller = TrainController();

  /// Selected origin station
  String? _from;

  /// Selected destination station
  String? _to;

  /// Number of passengers for the booking
  int _passengers = 1;

  /// Filtered list of trains available for the search criteria
  List<Train> _availableTrains = [];

  /// Searches trains based on origin, destination, and passenger count.
  ///
  /// Updates [_availableTrains] with trains that have enough available seats.
  void _searchTrains() {
    if (_from == null || _to == null) return;
    final allTrains = _controller.getTrainsByOrigin(_from!);
    final filtered = allTrains.where((t) => t.seats >= _passengers).toList();
    setState(() => _availableTrains = filtered);
  }

  @override
  Widget build(BuildContext context) {
    // List of all stations from controller
    final stations = _controller.getStations();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Train Booking'),
        backgroundColor: const Color(0xFF264653),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Trains',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Dropdown for origin station
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'From'),
              value: _from,
              items: stations
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _from = v),
            ),

            // Dropdown for destination station
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'To'),
              value: _to,
              items: stations
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _to = v),
            ),

            const SizedBox(height: 10),

            // Passenger count selector
            Row(
              children: [
                const Text('Passengers:'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_passengers > 1) {
                      setState(() => _passengers--);
                    }
                  },
                ),
                Text('$_passengers'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _passengers++),
                ),
              ],
            ),

            // Search button
            ElevatedButton(
              onPressed: _searchTrains,
              child: const Text('Search Available Trains'),
            ),

            const SizedBox(height: 20),

            const Text(
              'Available Trains',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Train list or empty message
            Expanded(
              child: _availableTrains.isEmpty
                  ? const Center(child: Text('No trains found.'))
                  : ListView.builder(
                itemCount: _availableTrains.length,
                itemBuilder: (_, i) {
                  final t = _availableTrains[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.train),
                      title: Text('${t.name} - ${t.type}'),
                      subtitle: Text(
                          'Seats: ${t.seats}, \$${t.pricePerSeat}/seat'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrainPayment(
                                train: t,
                                passengers: _passengers,
                                from: _from!,
                                to: _to!,
                              ),
                            ),
                          );
                        },
                        child: const Text('Book Now'),
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
