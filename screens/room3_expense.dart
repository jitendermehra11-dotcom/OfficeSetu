// lib/screens/room3_expense.dart
import 'package:flutter/material.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final List<Map<String, dynamic>> _expenses = [
    {"title": "ऑफिस स्टेशनरी और पेन", "amount": 450.0, "category": "Supplies"},
    {"title": "चाय और रिफ्रेशमेंट", "amount": 250.0, "category": "Food"},
    {"title": "मशीन मेंटेनेंस पार्ट", "amount": 1200.0, "category": "Maintenance"},
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  double get _totalExpense {
    return _expenses.fold(0.0, (sum, item) => sum + (item["amount"] as double));
  }

  void _addExpense() {
    if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      double? amt = double.tryParse(_amountController.text);
      if (amt != null) {
        setState(() {
          _expenses.add({
            "title": _titleController.text,
            "amount": amt,
            "category": "General",
          });
        });
        _titleController.clear();
        _amountController.clear();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('नया खर्च सफलतापूर्वक दर्ज किया गया!')),
        );
      }
    }
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('नया खर्च दर्ज करें (Add Expense)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'खर्च का विवरण (Description)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'रुपये (Amount in ₹)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('रद्द करें'),
          ),
          ElevatedButton(
            onPressed: _addExpense,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[900], foregroundColor: Colors.white),
            child: const Text('सेव करें'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room 03: Expense Tracker & Ledger'),
        backgroundColor: Colors.teal[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Total Expense Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  const Text('कुल खर्च (Total Office Expenses)', style: TextStyle(fontSize: 14, color: Colors.teal, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('₹ $_totalExpense', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[900])),
                ],
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _showAddExpenseDialog,
              icon: const Icon(Icons.add_circle, size: 20),
              label: const Text('नया खर्च जोड़ें (Add Expense)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'खर्चों का बही-खाता (Ledger History):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final exp = _expenses[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[700],
                        child: const Icon(Icons.receipt, color: Colors.white, size: 20),
                      ),
                      title: Text(exp["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('श्रेणी: ${exp["category"]}'),
                      trailing: Text(
                        '₹ ${exp["amount"]}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.teal[800]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
