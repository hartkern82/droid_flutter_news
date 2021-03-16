import 'package:flutter/material.dart';

class ContentImage extends StatelessWidget {
  final String path;

  ContentImage(this.path);

  @override
  Widget build(BuildContext context) {
    return (Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 25.0),
      child: Image.network(this.path.toString(), width: 200),
    ));
  }
}
