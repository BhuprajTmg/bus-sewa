import 'package:flutter/material.dart';

class addBus extends StatefulWidget {
  const addBus({Key key}) : super(key: key);
  static const routeName = '/adminAddbus';
  @override
  State<addBus> createState() => _addBusState();
}

class _addBusState extends State<addBus> {
  final TextEditingController busNameController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController ftimeController = TextEditingController();
  final TextEditingController pathController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController seatStatusController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController ttimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bus'),
        backgroundColor: Colors.blue, // Primary color (blue)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/as.png'), // Replace with the path to your GIF image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: busNameController,
                    decoration: const InputDecoration(labelText: 'Bus Name'),
                  ),
                  TextField(
                    controller: fromController,
                    decoration: const InputDecoration(labelText: 'From'),
                  ),
                  TextField(
                    controller: ftimeController,
                    decoration: const InputDecoration(labelText: 'From Time'),
                  ),
                  TextField(
                    controller: pathController,
                    decoration: const InputDecoration(labelText: 'Path'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  TextField(
                    controller: seatStatusController,
                    decoration: const InputDecoration(labelText: 'Seat Status'),
                  ),
                  TextField(
                    controller: toController,
                    decoration: const InputDecoration(labelText: 'To'),
                  ),
                  TextField(
                    controller: ttimeController,
                    decoration: const InputDecoration(labelText: 'To Time'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform the action you want when the button is pressed
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.save), // Secondary color (cyan)
      ),
    );

  }
}