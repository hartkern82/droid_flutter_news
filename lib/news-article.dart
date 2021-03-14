import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticleContent extends StatelessWidget {
  final List content;

  ArticleContent(this.content);

  //Hier JSON zerlegen

  @override
  Widget build(BuildContext context) {
    return Text(this
        .content
        .toString()); //hier soll später eine Liste mit Content (Überschrift, Headerbild und Paragraphs/Bilder übergeben werden)
  }
}

class Article extends StatelessWidget {
  final String cpArticleID;
  final String headline;
  final String datum;

  Article(this.cpArticleID, this.headline, this.datum);

  Future<List<dynamic>> fetchArticle() async {
    var result = await http.get(
        'https://praktikum.droidhosting.de/cockpit/api/collections/get/news?token=c6ef9e6fb4069e7c91e7f0046436c7' +
            '&filter[_id]=' +
            this.cpArticleID);
    return json.decode(result.body)['entries'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.datum + ' ' + this.headline),
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
                  return ArticleContent(snapshot
                      .data); //(Überschrift, Headerbild und Paragraphs/Bilder übergeben werden)
            }
          },
        ),
      ),
    );
  }
}
