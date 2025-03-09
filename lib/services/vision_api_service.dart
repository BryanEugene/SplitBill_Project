import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VisionApiService {
  final String apiKey = 'YOUR_GOOGLE_CLOUD_VISION_API_KEY'; // Ganti dengan API Key Anda
  final String visionUrl = 'https://vision.googleapis.com/v1/images:annotate';

  Future<String> detectTextFromImage(String imagePath) async {
    final File imageFile = File(imagePath);
    final List<int> imageBytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('$visionUrl?key=$apiKey'),
      body: jsonEncode({
        'requests': [
          {
            'image': {
              'content': base64Image,
            },
            'features': [
              {
                'type': 'TEXT_DETECTION',
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String detectedText = responseData['responses'][0]['fullTextAnnotation']['text'];
      return detectedText;
    } else {
      throw Exception('Failed to detect text: ${response.body}');
    }
  }
}