// OfficeSetu - Final Master Code (All 5 Rooms + Local Storage + PDF Export)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:convert';

void main() {
  runApp(const OfficeSetuApp());
}

class OfficeSetuApp extends StatelessWidget {
  const OfficeSetuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfficeSetu - Pro Office Automation',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
      ),
      home: const OfficeSetuDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OfficeSetuDashboard extends StatefulWidget {
  const OfficeSetuDashboard({Key? key}) : super(key: key);

  @override
  State<OfficeSetuDashboard> createState() => _OfficeSetuDashboardState();
}

class _OfficeSetuDashboardState extends State<OfficeSetuDashboard> {
  String _statusMessage = "लोकल स्टोरेज और पीडीएफ फीचर्स के साथ ऑफिस सेतु तैयार है!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfficeSetu (ऑफ़िस सेतु) - Master Pro'),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.withOpacity(0.3)),
              ),
              child: Text(
                _statusMessage,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.indigo[900]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),

            // Room 01 Button
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceMatchingScreen())),
              icon: const Icon(Icons.calendar_today, size: 20),
              label: const Text('Room 01: Attendance Matching', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),

            // Room 02 Button
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HRHelperScreen())),
              icon: const Icon(Icons.people, size: 20),
              label: const Text('Room 02: HR Helper (कर्मचारी प्रबंधन)', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),

            // Room 03 Button
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseTrackerScreen())),
              icon: const Icon(Icons.receipt_long, size: 20),
              label: const Text('Room 03: Expense Tracker (खर्च एवं बिल)', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),

            // Room 04 Button
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskHubScreen())),
              icon: const Icon(Icons.assignment, size: 20),
              label: const Text('Room 04: Task Hub (टास्क एवं असाइनमेंट)', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),

            // Room 05 Button
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceGeneratorScreen())),
              icon: const Icon(Icons.description, size: 20),
              label: const Text('Room 05: Invoice & PDF Generator', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const Spacer(),

            const Text(
              '© 2026 Jitender Mehra. All Rights Reserved.\nOfficeSetu - Pro Office Automation',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Room 01: Attendance Matching Screen
class AttendanceMatchingScreen extends StatelessWidget {
  const AttendanceMatchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 01: Attendance Matching'), backgroundColor: Colors.indigo[900]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Card(child: ListTile(title: Text('राजेश कुमार (EMP001)'), subtitle: Text('रफ एग्जिट: 18:30 | ओरिजिनल इन: 09:00'), trailing: Chip(label: Text('Matched 100%')))),
          Card(child: ListTile(title: Text('अमित शर्मा (EMP002)'), subtitle: Text('रफ एग्जिट: 19:00 | ओरिजिनल इन: 09:15'), trailing: Chip(label: Text('Matched 100%')))),
        ],
      ),
    );
  }
}

// Room 02: HR Helper Screen with Local Storage
class HRHelperScreen extends StatefulWidget {
  const HRHelperScreen({Key? key}) : super(key: key);

  @override
  State<HRHelperScreen> createState() => _HRHelperScreenState();
}

class _HRHelperScreenState extends State<HRHelperScreen> {
  List<Map<String, dynamic>> employeeList = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString('saved_employees');
    if (dataString != null) {
      setState(() {
        employeeList = List<Map<String, dynamic>>.from(json.decode(dataString));
      });
    } else {
      employeeList = [
        {"code": "EMP001", "name": "राजेश कुमार", "designation": "Delivery Rider", "status": "Active", "salary": "₹18,000"},
        {"code": "EMP002", "name": "अमित शर्मा", "designation": "Sales Manager", "status": "Active", "salary": "₹25,000"},
      ];
    }
  }

  Future<void> _saveEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_employees', json.encode(employeeList));
  }

  void _addNewEmployeeDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('नया कर्मचारी जोड़ें (Persistent)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'नाम')),
              TextField(controller: codeController, decoration: const InputDecoration(labelText: 'कोड (e.g., EMP003)')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करें')),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && codeController.text.isNotEmpty) {
                  setState(() {
                    employeeList.add({
                      "code": codeController.text,
                      "name": nameController.text,
                      "designation": "Staff",
                      "status": "Active",
                      "salary": "₹15,000"
                    });
                  });
                  _saveEmployees();
                  Navigator.pop(context);
                }
              },
              child: const Text('सेव करें'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room 02: HR Helper (Local Storage)'),
        backgroundColor: Colors.blueGrey[900],
        actions: [
          IconButton(icon: const Icon(Icons.person_add), onPressed: _addNewEmployeeDialog)
        ],
      ),
      body: ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (context, index) {
          final emp = employeeList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text('${emp["name"]} (${emp["code"]})', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${emp["designation"]} | वेतन: ${emp["salary"]}'),
              trailing: Chip(label: Text(emp["status"]), backgroundColor: Colors.green[100]),
            ),
          );
        },
      ),
    );
  }
}

// Room 03: Expense Tracker
class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 03: Expense Tracker'), backgroundColor: Colors.teal[900]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Card(child: ListTile(title: Text('ऑफिस बिजली बिल'), trailing: Text('₹2,400', style: TextStyle(fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
}

// Room 04: Task Hub
class TaskHubScreen extends StatelessWidget {
  const TaskHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 04: Task Hub'), backgroundColor: Colors.deepPurple[900]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Card(child: ListTile(title: Text('स्टॉक रजिस्टर का मिलान'), subtitle: Text('जिम्मा: राजेश कुमार'))),
        ],
      ),
    );
  }
}

// Room 05: Invoice & PDF Generator
class InvoiceGeneratorScreen extends StatefulWidget {
  const InvoiceGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceGeneratorScreen> createState() => _InvoiceGeneratorScreenState();
}

class _InvoiceGeneratorScreenState extends State<InvoiceGeneratorScreen> {
  final List<Map<String, dynamic>> invoiceList = [
    {"invoiceNo": "INV-101", "client": "श्री बालाजी ट्रेडर्स", "amount": "₹12,500"},
    {"invoiceNo": "INV-102", "client": "ओम साईं एजेंसी", "amount": "₹8,400"},
  ];

  Future<void> _generateAndPrintPDF(Map<String, dynamic> inv) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("OfficeSetu Official Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text("Invoice No: ${inv["invoiceNo"]}", style: const pw.TextStyle(fontSize: 16)),
                pw.Text("Client Name: ${inv["client"]}", style: const pw.TextStyle(fontSize: 16)),
                pw.Text("Total Amount: ${inv["amount"]}", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 40),
                pw.Text("Authorized Signature", style: const pw.TextStyle(fontSize: 14)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: '${inv["client"]}_Invoice.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 05: Invoice & PDF Generator'), backgroundColor: Colors.deepOrange[900]),
      body: ListView.builder(
        itemCount: invoiceList.length,
        itemBuilder: (context, index) {
          final inv = invoiceList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.deepOrange),
              title: Text('${inv["client"]} (${inv["invoiceNo"]})', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Tap to generate & share PDF'),
              trailing: Text(inv["amount"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () => _generateAndPrintPDF(inv),
            ),
          );
        },
      ),
    );
  }
}
