import 'dart:ui';
import 'dart:ui' as ui;

import 'package:catalogscanner/main.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'coordinates_translator.dart';

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(
      this.recognizedText, this.absoluteImageSize, this.rotation);

  final RecognizedText recognizedText;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.grey;

    final Paint background = Paint()..color = Color(0x99000000);

    for (TextBlock textBlock in recognizedText.blocks) {
      if (foundText.contains(textBlock.text)) {
        final ParagraphBuilder builder = ParagraphBuilder(
          ParagraphStyle(
              textAlign: TextAlign.left,
              fontSize: 16,
              textDirection: TextDirection.ltr),
        );
        builder.pushStyle(
            ui.TextStyle(color: Colors.green, background: background));
        builder.addText(textBlock.text);
        builder.pop();

        final left = translateX(
            textBlock.boundingBox.left, rotation, size, absoluteImageSize);
        final top = translateY(
            textBlock.boundingBox.top, rotation, size, absoluteImageSize);
        final right = translateX(
            textBlock.boundingBox.right, rotation, size, absoluteImageSize);
        final bottom = translateY(
            textBlock.boundingBox.bottom, rotation, size, absoluteImageSize);

        canvas.drawRect(
          Rect.fromLTRB(left, top, right, bottom),
          paint,
        );

        canvas.drawParagraph(
          builder.build()
            ..layout(ParagraphConstraints(
              width: right - left,
            )),
          Offset(left, top),
        );
      }
    }
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.recognizedText != recognizedText;
  }
}
