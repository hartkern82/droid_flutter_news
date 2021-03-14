import 'package:flutter/material.dart';
import 'package:news/news-list.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('droidNews'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[700]),
      body: Center(
        child: NewsList(),
      ),
    );
  }
}
