import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_app/json/Album.dart';
import 'package:web_app/json/Results.dart';
import 'package:web_app/screens/components/bar_chart.dart';

/// Displays the home page of our app.
/// It is initialized through the Main-Widget.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Results>> _futureResults;
  String URL = 'http://localhost:3000/results';

  @override
  void initState() {
    super.initState();
    //setUpTimedFetch();
    reload();
  }

  /// Refetches the api endpoint
  void reload() {
    setState(() {
      _futureResults = fetchResults();
    });
  }

  /// Refetches the api endpoint each 10 seconds
  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 10000), (timer) {
      setState(() {
        _futureResults = fetchResults();
      });
    });
  }

  /// Fetches a list of albums from the api endpoint
  Future<List<Results>> fetchResults() async {
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // store json data into list
      var list = json.decode(response.body) as List;

      // iterate over the list and map each object in list to Img by calling Img.fromJson
      List<Results> results = list.map((i) => Results.fromJson(i)).toList();

      print(results.runtimeType); //returns List<Img>
      print(results[0].runtimeType); //returns Img

      return results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  /// Generates simple bar chart
  SimpleBarChart getBarChart(List<Results> results) {
    return SimpleBarChart.withVoteSummaryData(results);
  }

  /// Builds the body of our application.
  Widget getBody(List<Results> results) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(results[0].candidate),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: getBarChart(results),
            ),
          )
        ],
      ),
    );
  }

  /// Generates a FutureBuilder for a list of albums
  FutureBuilder<List<Results>> getFutureBuilderAlbums() {
    return FutureBuilder<List<Results>>(
      future: _futureResults,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getBody(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
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
