import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_app/json/Album.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Album> futureAlbum;
  int index = 1;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  void reload() {
    setState(() {
      index = index + 1;
      futureAlbum = fetchAlbum();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting-Analysis'),
      ),
      body: getFutureBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => reload(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Album> fetchAlbum() async {
    print('https://jsonplaceholder.typicode.com/albums/$index');
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/$index');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  FutureBuilder<Album> getFutureBuilder() {
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.title);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
