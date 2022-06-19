import 'package:flutter/material.dart';
import 'package:frontend/languages/laguages.dart';

class TextLanguage extends StatelessWidget {
  String text;
  TextStyle? style;
  Languages languages = Languages();
  TextLanguage(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      languages.get(text),
      style: style,
    );
  }
}
