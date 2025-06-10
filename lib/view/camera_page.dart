import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:strawberry_disease_detection/model/plant.dart';
import 'package:strawberry_disease_detection/service/plant_service.dart';
import 'package:strawberry_disease_detection/utils/cloudinary_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final String apiKey = "QkpmzMMJT8hKnzFhWIKa";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        print("----------------------");
        print(image);
      });
    }
  }

  Future<void> _predictImage() async {
    if (image != null) {
      try {
        final bytes = await image!.readAsBytes();
        String base64Image = base64Encode(bytes);
        final mimeType = lookupMimeType(image!.path) ?? 'image/jpeg';
        final imageData = 'data:$mimeType;base64,$base64Image';

        final uri = Uri.parse(
            'https://detect.roboflow.com/strawberry-disease-detection-dataset/1?api_key=$apiKey');

        final response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'image': imageData}),

        );
        String _result = '';
        if (response.statusCode == 200) {
          setState(() {
            _result = response.body;
          });
        } else {
          setState(() {
            _result = 'Error: ${response.statusCode}';
          });
        }
      }catch(e) {
        print('Error: $e');
      }

    } else {
      print('No image selected');
    }
  }

  Future<void> pickAndPredictImage() async {
    Map<String, dynamic> result = {};
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    // loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                  "Processing...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );

    final bytes = await File(pickedFile.path).readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse("https://serverless.roboflow.com/strawberry-disease-detection-dataset/1?api_key=$apiKey"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: base64Image,
    );

    if (response.statusCode == 200) {
      print(response.body);

      // Decode response
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      result = decodedResponse;

      // upload image to Cloudinary
      final uid = _auth.currentUser?.uid ?? 'unknown';
      final imageUrl  = await uploadImageToCloudinary(pickedFile, uid);

      PlantService plantService = PlantService();
      Plant plant = Plant(
        imageUrl: imageUrl,
        date: DateTime.now(),
        diseases: result
      );
      // Close the loading dialog
      Navigator.pop(context);

      // Navigate to disease details page
      Navigator.pushNamed(
          context,
          '/disease_details',
          arguments: plant
      );

      // save to firebase database
      await plantService.addPlant(plant);


    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to predict image: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(TSize.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(TSize.defaultSpace),
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.send_rounded,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Predict Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Predict if strawberry is sick or not',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await pickAndPredictImage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Predict',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}