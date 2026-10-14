import 'package:flutter/material.dart';
class HRHelperScreen extends StatelessWidget {
  const HRHelperScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 02: HR Helper'), backgroundColor: Colors.blueGrey[900]),
      body: const Center(child: Text('HR Helper - Local Storage Active', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}
