// lib/screens/room2_hr.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

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
  bool _isProcessing = false;
  String _scanStatusText = "रजिस्टर स्कैन करके स्टाफ जोड़ने के लिए तैयार";

  // रजिस्टर या आईडी कार्ड की फोटो से OCR द्वारा स्टाफ नाम डिटेक्ट करके ऑटो-जोड़ने का इंजन
  Future<void> _scanAndAutoAddStaff() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _isProcessing = true;
        _scanStatusText = "फोटो स्कैन हो रही है और डेटा निकाला जा रहा है...";
      });

      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      String rawText = recognizedText.text;
      
      if (rawText.isNotEmpty) {
        // पहली लाइन या मिले हुए टेक्स्ट को नाम मानकर सूची में जोड़ना
        List<String> lines = rawText.split('\n');
        String extractedName = lines.isNotEmpty ? lines[0].trim() : "स्कैन किया गया स्टाफ";

        setState(() {
          _employees.add({
            "name": extractedName,
            "role": "General Staff (Auto-Scanned)",
            "status": "Active",
          });
          _scanStatusText = "सफलतापूर्वक स्कैन करके स्टाफ जोड़ दिया गया!";
          _isProcessing = false;
        });
      } else {
        setState(() {
          _scanStatusText = "फोटो में कोई स्पष्ट टेक्स्ट नहीं मिला।";
          _isProcessing = false;
        });
      }

      textRecognizer.close();
    }
  }

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
        title: const Text('Room 02: HR Helper & Auto-Excel Sync'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Action Buttons Row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showAddEmployeeDialog,
                    icon: const Icon(Icons.person_add, size: 18),
                    label: const Text('मैनुअल जोड़ें'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : _scanAndAutoAddStaff,
                    icon: const Icon(Icons.camera_alt, size: 18),
                    label: Text(_isProcessing ? 'स्कैनिंग...' : 'फोटो से ऑटो-जोड़ें'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(_scanStatusText, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            const Text(
              'सक्रिय कर्मचारियों की सूची (Excel Ready Database):',
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
