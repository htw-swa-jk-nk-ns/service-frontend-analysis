import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_app/json/Results.dart';
import 'package:web_app/screens/components/bar_chart.dart';

import '../../config.dart';

class CandidateBarChart extends StatefulWidget {
  @override
  _CandidateBarChartState createState() => _CandidateBarChartState();
}

class _CandidateBarChartState extends State<CandidateBarChart> {
  Future<List<Results>> _futureResults;

  //String URL_RESULTS = 'http://localhost:3000/results';

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
    //reload();
  }

  /// Refetches the api endpoint
  void reload() {
    setState(() {
      _futureResults = fetchResults();
    });
  }

  /// Refetches the api endpoint each 10 seconds
  setUpTimedFetch() {
    reload();
    Timer.periodic(Duration(milliseconds: FETCH_INTERFAL), (timer) {
      setState(() {
        _futureResults = fetchResults();
      });
    });
  }

  /// Fetches a list of albums from the api endpoint
  Future<List<Results>> fetchResults() async {
    print("URL:::$URL_RESULTS");
    final response = await http.get(URL_RESULTS);

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
      throw Exception('Failed to load overall results');
    }
  }

  /// Generates simple bar chart
  SimpleBarChart getBarChart(List<Results> results) {
    return SimpleBarChart.withVoteSummaryData(results);
  }

  /// Generates a FutureBuilder for a list of albums
  FutureBuilder<List<Results>> getFutureBuilderBarChart() {
    return FutureBuilder<List<Results>>(
      future: _futureResults,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getBarChart(snapshot.data);
        } else if (snapshot.hasError) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Could not fetch data (${snapshot.error}) retrying ..."),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            ],
          ));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getFutureBuilderBarChart();
  }
}
