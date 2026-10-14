import 'package:flutter/material.dart';
class InvoiceGeneratorScreen extends StatelessWidget {
  const InvoiceGeneratorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 05: Invoice Generator'), backgroundColor: Colors.deepOrange[900]),
      body: const Center(child: Text('Invoice Generator & PDF Screen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}
