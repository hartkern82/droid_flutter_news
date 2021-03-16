import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final String path;

  HeaderImage(this.path);

  @override
  Widget build(BuildContext context) {
    return (Image.network(this.path.toString()));
  }
}
