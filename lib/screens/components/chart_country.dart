import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_app/json/ResultsByCountry.dart';
import 'package:web_app/screens/components/pie_chart.dart';

class CountryBarChart extends StatefulWidget {
  @override
  _CountryBarChartState createState() => _CountryBarChartState();
}

class _CountryBarChartState extends State<CountryBarChart> {
  Future<List<ResultsByCountry>> _futureResultsByCountry;

  String URL_RESULTS_COUNTRY = 'http://localhost:3000/country';

  @override
  void initState() {
    super.initState();
    //setUpTimedFetch();
    reload();
  }

  /// Refetches the api endpoint
  void reload() {
    setState(() {
      _futureResultsByCountry = fetchResultsByCountry();
    });
  }

  /// Refetches the api endpoint each 10 seconds
  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 10000), (timer) {
      setState(() {
        _futureResultsByCountry = fetchResultsByCountry();
      });
    });
  }

  /// Fetches a list of albums from the api endpoint
  Future<List<ResultsByCountry>> fetchResultsByCountry() async {
    final response = await http.get(URL_RESULTS_COUNTRY);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // store json data into list
      var list = json.decode(response.body) as List;

      // iterate over the list and map each object in list to Img by calling Img.fromJson
      List<ResultsByCountry> results =
          list.map((i) => ResultsByCountry.fromJson(i)).toList();

      print(results.runtimeType); //returns List<Img>
      print(results[0].runtimeType); //returns Img

      return results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load results by country');
    }
  }

  /// Generates simple pie chart
  DonutAutoLabelChart getPieChart(List<ResultsByCountry> results) {
    return DonutAutoLabelChart.withResults(results);
  }

  /// Builds the body of our application.
  Widget getBodyPieChart(List<ResultsByCountry> results) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(results[0].country),
          Expanded(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: getPieChart(results),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Generates a FutureBuilder for a list of albums
  FutureBuilder<List<ResultsByCountry>> getFutureBuilderPieChart() {
    return FutureBuilder<List<ResultsByCountry>>(
      future: _futureResultsByCountry,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data[3].country);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getFutureBuilderPieChart();
  }
}
