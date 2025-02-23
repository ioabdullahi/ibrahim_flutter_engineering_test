class Property {
  final int id;
  final String name;
  final String location;
  final double price;
  final double latitude;
  final double longitude;
  final String imageUrl;

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
  });

  // Converts JSON into Property Object
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      price: json['price'].toDouble(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      imageUrl: json['imageUrl'],
    );
  }

  // Converts Property Object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
    };
  }
}
