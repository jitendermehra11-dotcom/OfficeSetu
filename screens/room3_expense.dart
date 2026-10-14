import 'package:flutter/material.dart';
class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 03: Expense Tracker'), backgroundColor: Colors.teal[900]),
      body: const Center(child: Text('Expense Tracker Screen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}
