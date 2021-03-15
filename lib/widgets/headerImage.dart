import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final String path;

  HeaderImage(this.path);

  pfad() {
    String pfad = this.path.toString();
    print(pfad);
    return pfad;
  }

  @override
  Widget build(BuildContext context) {
    return (Image.network(pfad()));
  }
}
