import 'package:flutter/material.dart';
import '../models/property.dart';

class PropertyDetailView extends StatelessWidget {
  final Property property;

  const PropertyDetailView({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(property.name)),
      body: Column(
        children: [
          Image.network(property.imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(property.location, style: TextStyle(fontSize: 18, color: Colors.grey)),
                Text("\$${property.price}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                ElevatedButton(onPressed: () {}, child: Text("Contact Seller")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
