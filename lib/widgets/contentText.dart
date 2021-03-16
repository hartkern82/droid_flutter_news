import 'dart:ui';
import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  final String text;

  ContentText(this.text);

  content() {
    String paragraph = this.text;
    paragraph = paragraph.replaceAll('<p>', '');
    paragraph = paragraph.replaceAll('</p>', ''); //geht bestimmt schöner!
    return paragraph;
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 25.0),
      child: Text(
        content(), //eigentlicher Text
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    ));
  }
}
