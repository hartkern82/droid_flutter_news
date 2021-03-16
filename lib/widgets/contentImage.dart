import 'package:flutter/material.dart';

class ContentImage extends StatelessWidget {
  final String path;

  ContentImage(this.path);

  // pfad() {
  //   String pfad = this.path.toString();
  //   print(pfad);
  //   return pfad;
  // }

  @override
  Widget build(BuildContext context) {
    return (Image.network(this.path.toString(), width: 200));
  }
}
