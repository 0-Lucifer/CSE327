import 'package:flutter/material.dart';
import 'train_controller.dart';
import 'train_model.dart';
import 'train_payment.dart';

class TrainRent extends StatefulWidget {
  const TrainRent({super.key});

  @override
  State<TrainRent> createState() => _TrainRentState();
}

class _TrainRentState extends State<TrainRent> {
  final TrainController _controller = TrainController();

  String? _from;
  String? _to;
  int _passengers = 1;
  List<Train> _availableTrains = [];

  void _searchTrains() {
    if (_from == null || _to == null) return;
    final allTrains = _controller.getTrainsByOrigin(_from!);
    final filtered = allTrains.where((t) => t.seats >= _passengers).toList();
    setState(() => _availableTrains = filtered);
  }

  @override
  Widget build(BuildContext context) {
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
            const Text('Search Trains', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'From'),
              value: _from,
              items: stations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _from = v),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'To'),
              value: _to,
              items: stations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _to = v),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Passengers:'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_passengers > 1) setState(() => _passengers--);
                  },
                ),
                Text('$_passengers'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _passengers++),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _searchTrains,
              child: const Text('Search Available Trains'),
            ),
            const SizedBox(height: 20),
            const Text('Available Trains', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
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
                      subtitle: Text('Seats: ${t.seats}, \$${t.pricePerSeat}/seat'),
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

