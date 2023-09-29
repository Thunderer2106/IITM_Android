import 'package:flutter/material.dart';
import 'package:iitm_android/screens/user/display_incident.dart';

class StateHome extends StatefulWidget {
  const StateHome({super.key});

  @override
  State<StateHome> createState() => _StateHomeState();
}

class _StateHomeState extends State<StateHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DEDB),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Stored Messages',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const ListIncidents(),
    );
  }
}
