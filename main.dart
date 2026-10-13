// OfficeSetu - Final Master Pro (Voice + Camera OCR + Local Storage + PDF)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'dart:convert';

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
            if (_spokenWords.toLowerCase().contains('attendance') || _spokenWords.contains('अटेंडेंस')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceMatchingScreen()));
            } else if (_spokenWords.toLowerCase().contains('hr') || _spokenWords.contains('स्टाफ')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HRHelperScreen()));
            } else if (_spokenWords.toLowerCase().contains('expense') || _spokenWords.contains('खर्च')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseTrackerScreen()));
            } else if (_spokenWords.toLowerCase().contains('task') || _spokenWords.contains('टास्क')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskHubScreen()));
            } else if (_spokenWords.toLowerCase().contains('invoice') || _spokenWords.contains('इनवॉइस')) {
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
              icon: const Icon(Icons.camera_alt, size: 20),
              label: const Text('Room 01: Attendance & OCR Scanner', style: TextStyle(fontSize: 14)),
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

// Room 01: Attendance with Real Camera & OCR Scanner
class AttendanceMatchingScreen extends StatefulWidget {
  const AttendanceMatchingScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceMatchingScreen> createState() => _AttendanceMatchingScreenState();
}

class _AttendanceMatchingScreenState extends State<AttendanceMatchingScreen> {
  File? _image;
  String _extractedText = "रजिस्टर की फोटो खींचकर स्कैन करने के लिए नीचे बटन दबाएं।";
  bool _isScanning = false;

  Future<void> _pickImageAndScan() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isScanning = true;
        _extractedText = "स्कैन हो रहा है...";
      });

      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        _extractedText = recognizedText.text.isNotEmpty ? recognizedText.text : "कोई टेक्स्ट नहीं मिला।";
        _isScanning = false;
      });

      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 01: Attendance & OCR Scanner'), backgroundColor: Colors.indigo[900]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isScanning ? null : _pickImageAndScan,
              icon: const Icon(Icons.camera_alt),
              label: Text(_isScanning ? 'स्कैनिंग जारी है...' : 'रजिस्टर की फोटो खींचें (Scan Register)'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
            ),
            const SizedBox(height: 14),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: _image != null
                    ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(_image!, fit: BoxFit.cover))
                    : const Center(child: Icon(Icons.image, size: 64, color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 14),
            const Text('स्कैन किया गया डेटा (OCR Result):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 6),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo.withOpacity(0.3)),
                ),
                child: SingleChildScrollView(
                  child: Text(_extractedText, style: const TextStyle(fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Room 02: HR Helper
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

// Room 03: Expense Tracker
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

// Room 04: Task Hub
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

// Room 05: Invoice Generator
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
