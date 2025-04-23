import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_disease_app/services/google_vision_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a clear image first.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String result = await GoogleVisionService.detectSkinDisease(_image!);
      Navigator.pushNamed(
        context,
        '/questionnaire',
        arguments: {
          'image': _image!.path,
          'imageResult': result,
        },
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to analyze image. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("Skin Disease Detector"),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Please upload a clear image of the affected skin area for accurate analysis.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: _image == null
                    ? Icon(Icons.image, size: 120, color: Colors.green[300])
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, height: 200),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Select Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _analyzeImage,
                  icon: const Icon(Icons.search),
                  label: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text("Analyze Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dermatologists');
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text("Find Nearby Dermatologists"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green[800],
                    side: BorderSide(color: Colors.green.shade700),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
