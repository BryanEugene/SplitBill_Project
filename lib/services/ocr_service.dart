// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

// class OCRService {
//   Future<String> detectTextFromImage(String imagePath) async {
//     final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFilePath(imagePath);
//     final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//     final VisionText visionText = await textRecognizer.processImage(visionImage);

//     String detectedText = '';
//     for (TextBlock block in visionText.blocks) {
//       for (TextLine line in block.lines) {
//         detectedText += line.text + '\n';
//       }
//     }

//     textRecognizer.close();
//     return detectedText;
//   }
// }

// void processDetectedText(String text) {
//   // Contoh sederhana untuk mengekstrak total harga
//   final totalRegex = RegExp(r'Total\s*:\s*(\d+(\.\d+)?)');
//   final match = totalRegex.firstMatch(text);
//   if (match != null) {
//     final totalAmount = double.parse(match.group(1)!);
//     print('Total Amount: $totalAmount');
//   }
// }