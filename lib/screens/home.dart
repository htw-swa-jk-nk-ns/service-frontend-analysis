import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_app/json/Album.dart';
import 'package:web_app/screens/components/bar_chart.dart';

/// Displays the home page of our app.
/// It is initialized through the Main-Widget.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Album> _futureAlbum;
  Future<List<Album>> _futureAlbums;
  int index = 1;

  @override
  void initState() {
    super.initState();
    //setUpTimedFetch();
    reload();
  }

  /// Refetches the api endpoint
  void reload() {
    setState(() {
      index = index + 1;
      //_futureAlbum = fetchAlbum();
      _futureAlbums = fetchAlbums();
    });
  }

  /// Refetches the api endpoint each 10 seconds
  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 10000), (timer) {
      setState(() {
        index = index + 1;
        _futureAlbum = fetchAlbum();
      });
    });
  }

  /// Fetches one Album from the api endpoint
  /// TODO replace with acutal vote class.
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

  /// Fetches a list of albums from the api endpoint
  /// TODO replace with acutal vote class.
  Future<List<Album>> fetchAlbums() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // store json data into list
      var list = json.decode(response.body) as List;

      // iterate over the list and map each object in list to Img by calling Img.fromJson
      List<Album> albums = list.map((i) => Album.fromJson(i)).toList();

      print(albums.runtimeType); //returns List<Img>
      print(albums[0].runtimeType); //returns Img

      return albums;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  /// Generates simple bar chart
  /// TODO generate bar chart based on actual data.
  SimpleBarChart getBarChart() {
    return SimpleBarChart.withSampleData();
  }

  /// Builds the body of our application.
  Widget getBody(List<Album> albums) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(albums[index].title),
          SizedBox(
            child: getBarChart(),
            width: 500,
            height: 500,
          )
        ],
      ),
    );
  }

  /// Generates a FutureBuilder for one album
  /// TODO replace with vote class
  FutureBuilder<Album> getFutureBuilderAlbum() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
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

  /// Generates a FutureBuilder for a list of albums
  /// TODO rpelace with vote class
  FutureBuilder<List<Album>> getFutureBuilderAlbums() {
    return FutureBuilder<List<Album>>(
      future: _futureAlbums,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getBody(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting-Analysis'),
      ),
      body: getFutureBuilderAlbums(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => reload(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
