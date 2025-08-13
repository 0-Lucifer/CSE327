import 'package:flutter/material.dart';
import 'bus_controller.dart';
import 'bus_model.dart';
import 'bus_payment.dart';

/// Transfers (Bus) — View (search/list)
///
/// UI for selecting origin & destination hubs in Dhaka, choosing passenger
/// count, listing available buses, and navigating to the payment screen.
class BusRent extends StatefulWidget {
  /// Creates the Transfers (Dhaka) search & list screen.
  const BusRent({super.key});

  @override
  State<BusRent> createState() => _BusRentState();
}

class _BusRentState extends State<BusRent> {
  /// Business logic provider for stations and buses (mirrors train controller pattern).
  final BusController _controller = BusController();

  /// Selected origin hub/station.
  String? _from;

  /// Selected destination hub/station.
  String? _to;

  /// Number of passengers for the booking (1–10).
  int _passengers = 1;

  /// Current search result set of available buses for [_from].
  List<Bus> _availableBuses = [];

  /// Queries the controller for buses from [_from] and updates the list.
  ///
  /// If [_from] is null, does nothing (keeps UX consistent with your train flow).
  void _searchBuses() {
    if (_from == null) return;
    setState(() {
      _availableBuses = _controller.getBusesByOrigin(_from!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stations = _controller.getStations();

    return Scaffold(
      appBar: AppBar(
        // Name it "Transfers" to match your dashboard label.
        title: const Text('Transfers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'From'),
              value: _from,
              items: stations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _from = v),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'To'),
              value: _to,
              items: stations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _to = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Passengers:'),
                const SizedBox(width: 12),
                DropdownButton<int>(
                  value: _passengers,
                  items: List.generate(10, (i) => i + 1)
                      .map((n) => DropdownMenuItem(value: n, child: Text('$n')))
                      .toList(),
                  onChanged: (v) => setState(() => _passengers = v ?? 1),
                ),
                const Spacer(),
                ElevatedButton(onPressed: _searchBuses, child: const Text('Search')),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _availableBuses.isEmpty
                  ? const Center(child: Text('No buses found. Select From and tap Search.'))
                  : ListView.separated(
                itemCount: _availableBuses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final bus = _availableBuses[i];
                  return Card(
                    child: ListTile(
                      title: Text('${bus.name} (${bus.type})'),
                      subtitle: Text('Seats: ${bus.seats} • Fare: ৳${bus.pricePerSeat.toStringAsFixed(0)} per person'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (_from == null || _to == null) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BusPayment(
                                bus: bus,
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
