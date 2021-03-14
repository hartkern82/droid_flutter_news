import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Article extends StatelessWidget {
  final String cpArticleID;

  Article(this.cpArticleID);

  Future<List<dynamic>> fetchArticle() async {
    var result = await http.get(
        'https://praktikum.droidhosting.de/cockpit/api/collections/get/news?token=c6ef9e6fb4069e7c91e7f0046436c7' +
            '&filter[_id]=' +
            this.cpArticleID);
    return json.decode(result.body)['entries'];
  }

  String _date(article) {
    return article['datum'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel' + this.cpArticleID),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchArticle(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Text('Result: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
