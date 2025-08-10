import 'train_model.dart';

class TrainController {
  final Map<String, List<Train>> _trainData = {
    'Dhaka': [
      Train(name: 'Sundarban Express', type: 'InterCity', seats: 400, pricePerSeat: 12.0),
      Train(name: 'Teesta Express', type: 'InterCity', seats: 320, pricePerSeat: 10.0),
    ],
    'Chattogram': [
      Train(name: 'Subarna Express', type: 'InterCity', seats: 300, pricePerSeat: 11.0),
      Train(name: 'Mohanagar Provati', type: 'InterCity', seats: 350, pricePerSeat: 9.5),
    ],
    'Rajshahi': [
      Train(name: 'Dhumketu Express', type: 'InterCity', seats: 280, pricePerSeat: 10.5),
      Train(name: 'Silk City Express', type: 'InterCity', seats: 260, pricePerSeat: 9.0),
    ],
    'Sylhet': [
      Train(name: 'Parabat Express', type: 'InterCity', seats: 220, pricePerSeat: 10.0),
      Train(name: 'Upaban Express', type: 'InterCity', seats: 240, pricePerSeat: 10.0),
    ],
  };

  List<String> getStations() => _trainData.keys.toList();

  List<Train> getTrainsByOrigin(String origin) => _trainData[origin] ?? [];
}