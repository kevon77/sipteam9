import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GoogleVisionService {
  static const String apiKey = "AIzaSyCjRIPqdiHXjpXUK1njZJfK9OBTl9OqJzs"; // Replace with your API key
  static const String apiUrl =
      "https://vision.googleapis.com/v1/images:annotate?key=$apiKey";

  static Future<String> detectSkinDisease(File imageFile) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var requestBody = jsonEncode({
        "requests": [
          {
            "image": {"content": base64Image},
            "features": [
              {"type": "WEB_DETECTION", "maxResults": 5},
              {"type": "DOCUMENT_TEXT_DETECTION"}
            ]
          }
        ]
      });

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var webResults = jsonResponse['responses'][0]['webDetection'];
        var textResults = jsonResponse['responses'][0]['fullTextAnnotation'];

        List<String> labels = [];

        // ✅ FIX: Ensure webResults exists before processing
        if (webResults != null && webResults['bestGuessLabels'] is List) {
          labels.addAll((webResults['bestGuessLabels'] as List)
              .map((label) => label['label'].toString())
              .toList());
        }

        String extractedText = textResults?['text'] ?? "";

        List<String> skinDiseases = [
          "acne", "eczema", "psoriasis", "melanoma", "dermatitis",
          "basal cell carcinoma", "squamous cell carcinoma", "rosacea", "vitiligo", "pimple", "blackhead", "whitehead", "blemish",
  "cystic acne", "comedone", "papule", "nodule" , "lupus", "ringworm"      
    ];

        for (String disease in skinDiseases) {
          if (extractedText.toLowerCase().contains(disease) ||
              labels.any((label) => label.toLowerCase().contains(disease))) {
            return "Detected: $disease";
          }
        }

        return "No specific skin disease detected. Try another image.";
      } else {
        return "API Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error analyzing image: $e";
    }
  }
}
