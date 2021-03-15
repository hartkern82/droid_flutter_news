import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news/widgets/headerImage.dart';

//wir brauchen noch 2 Klasen
//Content Image
//Content Text

class ArticleContent extends StatelessWidget {
  final List content;
  final String baseUrl = 'https://praktikum.droidhosting.de';

  ArticleContent(this.content);

  //Hier JSON zerlegen

  headLine() {
    List a = this.content;
    return a[0]['headline'];
  }

  headImage() {
    List a = this.content;
    print('Header Image Pfad ' + a[0]['headerImage']['path']);
    return (this.baseUrl + a[0]['headerImage']['path']);
  }

  contentText(iter) {
    List a = this.content;
    return a[0]['content'][iter]['value']['paragraph'];
  }

  contentImgage(iter) {
    List a = this.content;
    return (this.baseUrl + a[0]['content'][iter]['value']['image']['path']);
  }

  @override
  Widget build(BuildContext context) {
    // return Text(this
    //     .content
    //     .toString()); //hier soll später eine Liste mit Content (Überschrift, Headerbild und Paragraphs/Bilder übergeben werden)
    return Column(children: [
      Text(
        headLine(),
      ),
      HeaderImage(
        headImage(),
      ),
      Text(
        contentText(0),
      ),
      Text(
        contentImgage(1),
      ),
      Text(
        contentText(2),
      ),
    ]);
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
