class Train {
  final String name;        // e.g., "Sundarban Express"
  final String type;        // e.g., "InterCity", "Mail"
  final int seats;          // total/available seats used for simple filtering
  final double pricePerSeat; // price per passenger

  const Train({
    required this.name,
    required this.type,
    required this.seats,
    required this.pricePerSeat,
  });
}
