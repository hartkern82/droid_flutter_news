import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderHeadline extends StatelessWidget {
  final String text;

  HeaderHeadline(this.text);

  // content() {
  //   String headline = this.text;
  //   print(headline);
  //   return headline;
  // }

  @override
  Widget build(BuildContext context) {
    return (Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15.0),
      child: Text(
        this.text, //eigentlicher Text
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
