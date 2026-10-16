import 'package:flutter/material.dart';

/// Phase-1 placeholder. The full dashboard (GET /home) arrives in Phase 10.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CloudsBin')),
      body: const Center(child: Text('Signed in. Dashboard coming in Phase 10.')),
    );
  }
}
