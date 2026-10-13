// OfficeSetu - Master Single File Structure (Base + Room 01 + Room 02 + Room 03)
import 'package:flutter/material.dart';

void main() {
  runApp(const OfficeSetuApp());
}

class OfficeSetuApp extends StatelessWidget {
  const OfficeSetuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfficeSetu - Bol Ke Kaam Karao',
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
  String _statusMessage = "बोलो, लिखो या फोटो खींचो — ऑफिस सेतु तैयार है!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfficeSetu (ऑफ़िस सेतु)'),
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
            const SizedBox(height: 20),

            // Room 01 Navigation Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceMatchingScreen()),
                );
              },
              icon: const Icon(Icons.calendar_today, size: 24),
              label: const Text('Room 01: Attendance Matching (अटेंडेंस मिलान)', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),

            // Room 02 Navigation Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HRHelperScreen()),
                );
              },
              icon: const Icon(Icons.people, size: 24),
              label: const Text('Room 02: HR Helper (कर्मचारी एवं वेतन प्रबंधन)', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),

            // Room 03 Navigation Button (Expense Tracker)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExpenseTrackerScreen()),
                );
              },
              icon: const Icon(Icons.receipt_long, size: 24),
              label: const Text('Room 03: Expense & Bill Tracker (खर्च एवं बिल)', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),

            // Voice Command Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _statusMessage = "🎙️ सुन रहा हूँ... बोलिए क्या काम करना है?";
                });
              },
              icon: const Icon(Icons.mic, size: 24),
              label: const Text('बोलकर काम कराओ (Voice Command)', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),

            // Camera Scan Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _statusMessage = "📷 कैमरा चालू है... रजिस्टर या डॉक्यूमेंट की फोटो खींचें।";
                });
              },
              icon: const Icon(Icons.camera_alt, size: 24),
              label: const Text('फोटो खींचें & ऑटो-क्लीन (Scan & Clean)', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Spacer(),

            const Text(
              '© 2026 Jitender Mehra. All Rights Reserved.\nOfficeSetu - Secure Cross-Platform Office Automation',
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
class AttendanceMatchingScreen extends StatefulWidget {
  const AttendanceMatchingScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceMatchingScreen> createState() => _AttendanceMatchingScreenState();
}

class _AttendanceMatchingScreenState extends State<AttendanceMatchingScreen> {
  final List<Map<String, dynamic>> attendanceRecords = [
    {"code": "EMP001", "name": "राजेश कुमार", "roughExit": "18:30", "origCheckIn": "09:00", "status": "Matched 100%"},
    {"code": "EMP002", "name": "अमित शर्मा", "roughExit": "19:00", "origCheckIn": "09:15", "status": "Matched 100%"},
    {"code": "EMP003", "name": "सुनील वर्मा", "roughExit": "18:00", "origCheckIn": "09:00", "status": "Pending Match"},
  ];

  bool _isProcessing = false;

  void _runSmartMatching() {
    setState(() {
      _isProcessing = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
        for (var record in attendanceRecords) {
          record["status"] = "Verified & Synced (100%)";
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ रफ और ओरिजिनल रजिस्टर का मिलान सफलतापूर्व पूरा हुआ!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room 01: Attendance Matching'),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'रजिस्टर मिलान इंजन (Smart Reconciliation)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'रफ रजिस्टर से एग्जिट टाइम उठाकर ओरिजिनल रजिस्टर के कोड के साथ 100% सटीकता से मिलान करें।',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _isProcessing ? null : _runSmartMatching,
                      icon: const Icon(Icons.sync),
                      label: Text(_isProcessing ? 'मिलान हो रहा है...' : 'ऑटो-मैच शुरू करें (Start Matching)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'कर्मचारी अटेंडेंस लॉग सूची:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  final record = attendanceRecords[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo[100],
                        child: Text(record["code"].toString().substring(3)),
                      ),
                      title: Text('${record["name"]} (${record["code"]})', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('रफ एग्जिट: ${record["roughExit"]} | ओरिजिनल इन: ${record["origCheckIn']}'),
                      trailing: Chip(
                        label: Text(record["status"], style: const TextStyle(fontSize: 12, color: Colors.white)),
                        backgroundColor: record["status"].contains("100") || record["status"].contains("Verified") ? Colors.green : Colors.orange,
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

// Room 02: HR Helper Screen
class HRHelperScreen extends StatefulWidget {
  const HRHelperScreen({Key? key}) : super(key: key);

  @override
  State<HRHelperScreen> createState() => _HRHelperScreenState();
}

class _HRHelperScreenState extends State<HRHelperScreen> {
  final List<Map<String, dynamic>> employeeList = [
    {"code": "EMP001", "name": "राजेश कुमार", "designation": "Delivery Rider / Staff", "status": "Active", "salary": "₹18,000"},
    {"code": "EMP002", "name": "अमित शर्मा", "designation": "Sales Manager (SM)", "status": "Active", "salary": "₹25,000"},
    {"code": "EMP003", "name": "सुनील वर्मा", "designation": "Support Executive", "status": "On Leave", "salary": "₹15,000"},
  ];

  void _addNewEmployeeDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('नया कर्मचारी जोड़ें (Add Employee)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'कर्मचारी का नाम (Name)'),
              ),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'कर्मचारी कोड (Code e.g., EMP004)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('रद्द करें (Cancel)'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && codeController.text.isNotEmpty) {
                  setState(() {
                    employeeList.add({
                      "code": codeController.text,
                      "name": nameController.text,
                      "designation": "New Staff",
                      "status": "Active",
                      "salary": "TBD"
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('सेव करें (Save)'),
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
        title: const Text('Room 02: HR Helper'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'कुल स्टाफ: ${employeeList.length} सक्रिय',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'वेतन और डेजिग्नेशन रिकॉर्ड अपडेटेड',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: _addNewEmployeeDialog,
                      icon: const Icon(Icons.person_add, size: 18),
                      label: const Text('नया जोड़ें'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'कर्मचारी सूची एवं विवरण:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  final emp = employeeList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey[100],
                        child: Text(emp["code"].toString().length > 3 ? emp["code"].toString().substring(3) : emp["code"]),
                      ),
                      title: Text('${emp["name"]} (${emp["code"]})', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${emp["designation"]} | वेतन: ${emp["salary"]}'),
                      trailing: Chip(
                        label: Text(emp["status"], style: const TextStyle(fontSize: 12, color: Colors.white)),
                        backgroundColor: emp["status"] == "Active" ? Colors.green : Colors.amber[800],
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

// Room 03: Expense & Bill Tracker Screen
class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final List<Map<String, dynamic>> expenseList = [
    {"title": "ऑफिस बिजली बिल", "amount": "₹2,400", "date": "12 Oct 2026", "status": "Paid"},
    {"title": "इंटरनेट वाई-फाई रिचार्ज", "amount": "₹999", "date": "10 Oct 2026", "status": "Paid"},
    {"title": "स्टेशनरी और प्रिंटिंग पेपर", "amount": "₹1,500", "date": "08 Oct 2026", "status": "Pending"},
  ];

  void _addExpenseDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('नया खर्च जोड़ें (Add Expense)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'खर्च का विवरण (Title)'),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'राशि (Amount e.g., 500)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('रद्द करें'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                  setState(() {
                    expenseList.insert(0, {
                      "title": titleController.text,
                      "amount": "₹${amountController.text}",
                      "date": "आज",
                      "status": "Pending"
                    });
                  });
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
        title: const Text('Room 03: Expense & Bill Tracker'),
        backgroundColor: Colors.teal[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'कुल खर्च: ${expenseList.length} मद',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'बिलों और भुगतानों पर नजर रखें',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: _addExpenseDialog,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('खर्च जोड़ें'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'हालिया खर्च और बिल सूची:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: expenseList.length,
                itemBuilder: (context, index) {
                  final exp = expenseList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[100],
                        child: const Icon(Icons.receipt_long, color: Colors.teal),
                      ),
                      title: Text(exp["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('तारीख: ${exp["date"]}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(exp["amount"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text(exp["status"], style: const TextStyle(fontSize: 11, color: Colors.white)),
                            backgroundColor: exp["status"] == "Paid" ? Colors.green : Colors.deepOrange,
                          ),
                        ],
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
