import 'package:flutter/material.dart';

class TextFont extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? textColor;
  final TextAlign textAlign;
  final int? maxLines;
  final bool fixParagraphMargin;
  final TextOverflow? overflow;
  final bool? softWrap;

  const TextFont({
    Key? key,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textColor,
    this.maxLines = null,
    this.fixParagraphMargin = false,
    this.overflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finalTextColor;
    if (this.textColor == null) {
      finalTextColor = Theme.of(context).textTheme.bodyMedium!.color;
    } else {
      finalTextColor = textColor;
    }
    final TextStyle textStyle = TextStyle(
      fontWeight: this.fontWeight,
      fontSize: this.fontSize,
      fontFamily: 'Avenir',
      color: finalTextColor,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.double,
      decorationColor: Color(0x00FFFFFF),
      overflow: overflow,
      height: 1.1,
    );
    return Text(
      "$text",
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: textStyle,
      softWrap: softWrap,
    );
  }
}
