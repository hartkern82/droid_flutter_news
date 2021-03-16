import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news/widgets/headerHeadline.dart'; //Article Headline
import 'package:news/widgets/headerImage.dart'; //Article Heading Bild
import 'package:news/widgets/contentText.dart'; //Article Content Text
import 'package:news/widgets/contentImage.dart'; //Article Content Image

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

  contentImage(iter) {
    List a = this.content;
    return (this.baseUrl + a[0]['content'][iter]['value']['image']['path']);
  }

  contentList() {
    var list = SingleChildScrollView(
      child: Column(children: [
        HeaderHeadline(
          headLine(),
        ),
        HeaderImage(
          headImage(),
        ),
        ContentText(
          contentText(0),
        ),
        ContentImage(
          contentImage(1),
        ),
        ContentText(
          contentText(2),
        ),
      ]),
    );

    var dynamicContentList = Column(children: []);
    dynamicContentList.children
        .add(HeaderHeadline(headLine())); // Artikelüberschrift
    dynamicContentList.children.add(HeaderImage(headImage())); // Artikelbild

    //hier kommt die Schleife für den eigentlichen dynamischen Content

    return SingleChildScrollView(child: dynamicContentList);
  }

  @override
  Widget build(BuildContext context) {
    return contentList(); //hier soll später eine Liste mit Content (Überschrift, Headerbild und Paragraphs/Bilder übergeben werden)
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
