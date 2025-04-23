import 'dart:io';
import 'package:flutter/material.dart';
import 'disease_info_screen.dart';

class ResultsScreen extends StatelessWidget {
  final String image;
  final String result;
  final Map<String, dynamic> questionnaire;

  const ResultsScreen({
    Key? key,
    required this.image,
    required this.result,
    required this.questionnaire,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(image), height: 220, fit: BoxFit.cover),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Detected Result:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Answers:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...questionnaire.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.key}: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text('${entry.value}')),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/dermatologists');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.location_on, color: Colors.white),
              label: const Text(
                "Find Nearby Dermatologists",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseInfoScreen(diseaseName: result,questionnaire: questionnaire,),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.info_outline, color: Colors.white),
              label: const Text(
                "More Info",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
