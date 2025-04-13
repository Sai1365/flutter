import 'package:flutter/material.dart';

class CardOperationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Operations')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const Text(
                'Card Operations',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Initiating Card Activation...')),
                  );
                  // Implement card activation logic
                },
                child: const Text('Activate Card'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Initiating Block Card...')),
                  );
                  // Implement block card logic
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text('Block Card'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Initiating Check Balance...')),
                  );
                  // Implement check balance logic
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Check Balance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}