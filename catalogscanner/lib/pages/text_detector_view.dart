import 'dart:convert';
import 'dart:developer';

import 'package:catalogscanner/data/dataSet.dart';
import 'package:catalogscanner/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/camera_view.dart';
import '../widgets/text_detector_painter.dart';

class TextRecognizerPage extends StatelessWidget {
  const TextRecognizerPage({super.key, required this.setPage});

  final Function(int) setPage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setPage(0);
        await saveFoundText();
        return false;
      },
      child: Scaffold(
        body: TextRecognizerView(setPage: setPage),
      ),
    );
  }
}

class TextRecognizerView extends StatefulWidget {
  const TextRecognizerView({super.key, required this.setPage});
  final Function(int) setPage;

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  int numberNew = 0;
  Set currentlyDisplayedText = {};

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return CameraView(
      title: 'Text Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      setPage: widget.setPage,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      TextRecognizerPainter painter = TextRecognizerPainter(
          recognizedText,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
      for (TextBlock textBlock in recognizedText.blocks) {
        // Only start scanning if it found 3 (of any) entries in the frame
        // if (currentlyDisplayedText.length >= 3) {
        if (dataset[textBlock.text] != null &&
            foundText.contains(textBlock.text)) {
          continue;
        } else if (dataset[textBlock.text] != null) {
          foundText.add(textBlock.text);
          globalOverlayStackKey.currentState!.post(textBlock.text);
          numberNew++;
        }
        if (numberNew >= 8) {
          globalOverlayCanScrollStackKey.currentState!.post(true);
          numberNew = 0;
          saveFoundText();
        }
        // }
        // if (dataset.contains(textBlock.text)) {
        //   currentlyDisplayedText.add(textBlock.text);
        // }
      }
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
