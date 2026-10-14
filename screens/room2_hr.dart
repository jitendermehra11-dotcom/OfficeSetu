// lib/screens/room2_hr.dart
import 'package:flutter/material.dart';

class HRHelperScreen extends StatefulWidget {
  const HRHelperScreen({Key? key}) : super(key: key);

  @override
  State<HRHelperScreen> createState() => _HRHelperScreenState();
}

class _HRHelperScreenState extends State<HRHelperScreen> {
  final List<Map<String, String>> _employees = [
    {"name": "राजेश कुमार", "role": "Shift Supervisor", "status": "Active"},
    {"name": "अमित शर्मा", "role": "Machine Operator", "status": "Active"},
    {"name": "सुनील वर्मा", "role": "Quality Inspector", "status": "On Leave"},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  void _addNewEmployee() {
    if (_nameController.text.isNotEmpty && _roleController.text.isNotEmpty) {
      setState(() {
        _employees.add({
          "name": _nameController.text,
          "role": _roleController.text,
          "status": "Active",
        });
      });
      _nameController.clear();
      _roleController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('नया कर्मचारी सफलतापूर्वक जोड़ा गया!')),
      );
    }
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('नया स्टाफ/कर्मचारी जोड़ें'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'कर्मचारी का नाम (Employee Name)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(labelText: 'पद / भूमिका (Role/Designation)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('रद्द करें'),
          ),
          ElevatedButton(
            onPressed: _addNewEmployee,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[900], foregroundColor: Colors.white),
            child: const Text('जोड़ें (Save)'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room 02: HR Helper & Staff Database'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _showAddEmployeeDialog,
              icon: const Icon(Icons.person_add),
              label: const Text('नया कर्मचारी रजिस्टर करें (Add Employee)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'सक्रिय कर्मचारियों की सूची (Active Staff Database):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _employees.length,
                itemBuilder: (context, index) {
                  final emp = _employees[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey[700],
                        child: Text(emp["name"]![0], style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(emp["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('पद: ${emp["role"]}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: emp["status"] == "Active" ? Colors.green[100] : Colors.orange[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          emp["status"]!,
                          style: TextStyle(
                            color: emp["status"] == "Active" ? Colors.green[800] : Colors.orange[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
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
