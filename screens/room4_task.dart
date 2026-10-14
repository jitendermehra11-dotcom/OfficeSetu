import 'package:flutter/material.dart';
class TaskHubScreen extends StatelessWidget {
  const TaskHubScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 04: Task Hub'), backgroundColor: Colors.deepPurple[900]),
      body: const Center(child: Text('Task Hub Screen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}
