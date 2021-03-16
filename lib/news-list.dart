import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/news-article.dart';
import 'dart:convert';

class NewsList extends StatelessWidget {
  final String cockpitURL =
      'https://praktikum.droidhosting.de/cockpit/api/collections/get/news?token=c6ef9e6fb4069e7c91e7f0046436c7';

  Future<List<dynamic>> fetchNews() async {
    var result = await http.get(cockpitURL);
    return json.decode(result.body)['entries'];
  }

  String _date(dynamic news) {
    return news['datum'];
  }

  String _heading(dynamic news) {
    return news['headline'];
  }

  String _articleID(dynamic news) {
    return news['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.article_rounded),
                            title: Text(_heading(snapshot.data[index])),
                            subtitle: Text(_date(snapshot.data[index])),
                            // trailing: Text(_articleID(
                            // snapshot.data[index])), //nur zum Debug
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Article(
                                  _articleID(snapshot.data[index]),
                                  _heading(snapshot.data[index]),
                                  _date(snapshot.data[index]),
                                );
                              }));
                            },
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
