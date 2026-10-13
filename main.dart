// OfficeSetu - Master Single File Structure (Base + Room 01: Attendance Matching)
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
      debugShowCheckedModeBanner: false, // Hides the debug banner
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
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Message Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.withOpacity(0.3)),
              ),
              child: Text(
                _statusMessage,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo[900]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Room 01 Navigation Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AttendanceMatchingScreen()),
                );
              },
              icon: const Icon(Icons.calendar_today, size: 24),
              label: const Text('Room 01: Attendance Matching (अटेंडेंस मिलान)',
                  style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),

            // Voice Command Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _statusMessage = "🎙️ सुन रहा हूँ... बोलिए क्या काम करना है?";
                });
              },
              icon: const Icon(Icons.mic, size: 24),
              label: const Text('बोलकर काम कराओ (Voice Command)',
                  style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),

            // Camera Scan Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _statusMessage =
                      "📷 कैमरा चालू है... रजिस्टर या डॉक्यूमेंट की फोटो खींचें।";
                });
              },
              icon: const Icon(Icons.camera_alt, size: 24),
              label: const Text('फोटो खींचें & ऑटो-क्लीन (Scan & Clean)',
                  style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Spacer(),

            // Footer
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
  State<AttendanceMatchingScreen> createState() =>
      _AttendanceMatchingScreenState();
}

class _AttendanceMatchingScreenState extends State<AttendanceMatchingScreen> {
  // Mock Data
  final List<Map<String, dynamic>> attendanceRecords = [
    {
      "code": "EMP001",
      "name": "राजेश कुमार",
      "roughExit": "18:30",
      "origCheckIn": "09:00",
      "status": "Matched 100%"
    },
    {
      "code": "EMP002",
      "name": "अमित शर्मा",
      "roughExit": "19:00",
      "origCheckIn": "09:15",
      "status": "Matched 100%"
    },
    {
      "code": "EMP003",
      "name": "सुनील वर्मा",
      "roughExit": "18:00",
      "origCheckIn": "09:00",
      "status": "Pending Match"
    },
  ];

  bool _isProcessing = false;

  void _runSmartMatching() {
    setState(() {
      _isProcessing = true;
    });

    // Simulating network/processing delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
        for (var record in attendanceRecords) {
          record["status"] = "Verified & Synced (100%)";
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ रफ और ओरिजिनल रजिस्टर का मिलान सफलतापूर्व पूरा हुआ!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room 01: Attendance Matching'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'रजिस्टर मिलान इंजन (Smart Reconciliation)',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'रफ रजिस्टर से एग्जिट टाइम उठाकर ओरिजिनल रजिस्टर के कोड के साथ 100% सटीकता से मिलान करें।',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _isProcessing ? null : _runSmartMatching,
                      icon: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.sync),
                      label: Text(_isProcessing
                          ? 'मिलान हो रहा है...'
                          : 'ऑटो-मैच शुरू करें (Start Matching)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
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
                  bool isVerified = record["status"].contains("100") ||
                      record["status"].contains("Verified");

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo[100],
                        child: Text(
                          record["code"].toString().substring(3),
                          style: TextStyle(color: Colors.indigo[900]),
                        ),
                      ),
                      title: Text(
                        '${record["name"]} (${record["code"]})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // FIXED SYNTAX ERROR HERE:
                      subtitle: Text(
                          'रफ एग्जिट: ${record["roughExit"]} | ओरिजिनल इन: ${record["origCheckIn"]}'),
                      trailing: Chip(
                        label: Text(
                          record["status"],
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        backgroundColor:
                            isVerified ? Colors.green : Colors.orange,
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
