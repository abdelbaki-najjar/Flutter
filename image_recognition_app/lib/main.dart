import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() => runApp(ImageRecognitionApp());

class ImageRecognitionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Recognition',
      home: ImageRecognitionScreen(),
    );
  }
}

class ImageRecognitionScreen extends StatefulWidget {
  @override
  _ImageRecognitionScreenState createState() => _ImageRecognitionScreenState();
}

class _ImageRecognitionScreenState extends State<ImageRecognitionScreen> {
  File? _image;
  String _result = "Upload an image to recognize objects.";
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _processImage(_image!);
    }
  }

  Future<void> _processImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final imageLabeler = GoogleMlKit.vision.imageLabeler();

    final labels = await imageLabeler.processImage(inputImage);
    setState(() {
      _result = labels.map((label) => '${label.label} (${label.confidence.toStringAsFixed(2)})').join('\n');
    });

    imageLabeler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Recognition'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null
              ? Image.file(_image!, height: 300)
              : Placeholder(fallbackHeight: 300),
          SizedBox(height: 20),
          Text(_result, textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
