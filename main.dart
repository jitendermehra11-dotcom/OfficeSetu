// OfficeSetu - Main Entry Point (Modular & Clean)
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'screens/room1_attendance.dart';
import 'screens/room2_hr.dart';
import 'screens/room3_expense.dart';
import 'screens/room4_task.dart';
import 'screens/room5_invoice.dart';

void main() {
  runApp(const OfficeSetuApp());
}

class OfficeSetuApp extends StatelessWidget {
  const OfficeSetuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfficeSetu - Ultimate Pro',
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
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenWords = "माइक बटन दबाएं या कमरे चुनें!";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _spokenWords = val.recognizedWords;
            String cmd = _spokenWords.toLowerCase();
            if (cmd.contains('attendance') || cmd.contains('अटेंडेंस')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceMatchingScreen()));
            } else if (cmd.contains('hr') || cmd.contains('स्टाफ')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HRHelperScreen()));
            } else if (cmd.contains('expense') || cmd.contains('खर्च')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseTrackerScreen()));
            } else if (cmd.contains('task') || cmd.contains('टास्क')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskHubScreen()));
            } else if (cmd.contains('invoice') || cmd.contains('इनवॉइस')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceGeneratorScreen()));
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfficeSetu (ऑफ़िस सेतु) - Ultimate Pro'),
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
                color: _isListening ? Colors.teal[50] : Colors.indigo[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isListening ? Colors.teal : Colors.indigo.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(_isListening ? Icons.mic : Icons.mic_none, size: 32, color: _isListening ? Colors.teal : Colors.indigo[900]),
                  const SizedBox(height: 6),
                  Text(_spokenWords, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo[900]), textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Room Buttons
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceMatchingScreen())),
              icon: const Icon(Icons.verified, size: 20),
              label: const Text('Room 01: Strict Attendance & OCR Matching', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HRHelperScreen())),
              icon: const Icon(Icons.people, size: 20),
              label: const Text('Room 02: HR Helper (Local Storage)', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseTrackerScreen())),
              icon: const Icon(Icons.receipt_long, size: 20),
              label: const Text('Room 03: Expense Tracker', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskHubScreen())),
              icon: const Icon(Icons.assignment, size: 20),
              label: const Text('Room 04: Task Hub', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceGeneratorScreen())),
              icon: const Icon(Icons.description, size: 20),
              label: const Text('Room 05: Invoice & PDF Generator', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const Divider(height: 20),

            // Voice Command Button
            ElevatedButton.icon(
              onPressed: _listen,
              icon: Icon(_isListening ? Icons.stop : Icons.mic, size: 20),
              label: Text(_isListening ? 'सुन रहा हूँ...' : 'बोलकर नेविगेट करें (Voice Command)', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: _isListening ? Colors.red : Colors.teal[700], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
            const Spacer(),
            const Text('© 2026 Jitender Mehra. OfficeSetu Ultimate', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
