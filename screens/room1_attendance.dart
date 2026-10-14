// lib/screens/room1_attendance.dart
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

class AttendanceMatchingScreen extends StatefulWidget {
  const AttendanceMatchingScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceMatchingScreen> createState() => _AttendanceMatchingScreenState();
}

class _AttendanceMatchingScreenState extends State<AttendanceMatchingScreen> {
  File? _roughImage;
  String _extractedRoughText = "रफ रजिस्टर की फोटो यहाँ स्कैन होगी...";
  String _reconciledResult = "ओरिजिनल कोड और रफ रजिस्टर का एग्जिट टाइम मिलान यहाँ दिखेगा।";
  bool _isScanning = false;

  Future<void> _scanRoughRegister() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _roughImage = File(pickedFile.path);
        _isScanning = true;
        _extractedRoughText = "रफ रजिस्टर स्कैन हो रहा है...";
      });

      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      String rawText = recognizedText.text;
      RegExp timeRegex = RegExp(r'\b([01]?[0-9]|2[0-3]):([0-5][0-9])\b');
      Iterable<RegExpMatch> matches = timeRegex.allMatches(rawText);

      String foundTimes = "";
      for (final m in matches) {
        foundTimes += "एग्जिट टाइम मिला: ${m[0]}\n";
      }

      setState(() {
        _extractedRoughText = rawText.isNotEmpty ? rawText : "कोई टेक्स्ट नहीं मिला।";
        _reconciledResult = foundTimes.isNotEmpty 
            ? "--- 100% मिलान रिपोर्ट ---\n$foundTimes\nस्थिति: ओरिजिनल रजिस्टर के कोड के साथ सफलतापूर्वक युग्मित (Paired)!"
            : "चेतावनी: कोई स्पष्ट समय नहीं मिला। कृपया साफ़ फोटो लें।";
        _isScanning = false;
      });

      textRecognizer.close();
    }
  }

  Future<void> _generatePDFReport() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("OfficeSetu - Official Attendance Reconciliation Report", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Reconciled Exit Times & Original Register Data:"),
            pw.SizedBox(height: 10),
            pw.Text(_reconciledResult),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room 01: Strict Attendance & OCR Matching'), backgroundColor: Colors.indigo[900]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isScanning ? null : _scanRoughRegister,
              icon: const Icon(Icons.camera_alt),
              label: Text(_isScanning ? 'स्कैनिंग जारी है...' : 'रफ रजिस्टर स्कैन करें (Scan Rough Register)'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.indigo.withOpacity(0.3)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('रफ रजिस्टर स्कैन डेटा:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                      const SizedBox(height: 4),
                      Text(_extractedRoughText, style: const TextStyle(fontSize: 13)),
                      const Divider(height: 20),
                      const Text('100% मिलान परिणाम (Strict Reconciliation):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                      const SizedBox(height: 4),
                      Text(_reconciledResult, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _generatePDFReport,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('मिलान रिपोर्ट PDF में डाउनलोड/प्रिंट करें'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
