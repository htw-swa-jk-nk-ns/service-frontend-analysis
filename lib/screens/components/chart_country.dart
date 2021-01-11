import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_app/json/ResultsByCountry.dart';
import 'package:web_app/screens/components/pie_chart.dart';

import '../../config.dart';

class CountryBarChart extends StatefulWidget {
  @override
  _CountryBarChartState createState() => _CountryBarChartState();
}

class _CountryBarChartState extends State<CountryBarChart> {
  Future<List<ResultsByCountry>> _futureResultsByCountry;

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
    //reload();
  }

  /// Refetches the api endpoint
  void reload() {
    setState(() {
      try {
        _futureResultsByCountry = fetchResultsByCountry();
      } catch (error) {
        print('Error while fetching country data');
      }
    });
  }

  /// Refetches the api endpoint each 10 seconds
  setUpTimedFetch() {
    reload();
    Timer.periodic(Duration(milliseconds: FETCH_INTERFAL), (timer) {
      setState(() {
        _futureResultsByCountry = fetchResultsByCountry();
      });
    });
  }

  /// Fetches a list of albums from the api endpoint
  Future<List<ResultsByCountry>> fetchResultsByCountry() async {
    print("COUNTRY_URL:::${URL_RESULTS_COUNTRY}");
    final response = await http.get(URL_RESULTS_COUNTRY);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // store json data into list
      var list = json.decode(response.body) as List;

      // iterate over the list and map each object in list to Img by calling Img.fromJson
      List<ResultsByCountry> results =
          list.map((i) => ResultsByCountry.fromJson(i)).toList();

      //print(results.runtimeType); //returns List<Img>
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

  /// Generates a FutureBuilder for a list of albums
  FutureBuilder<List<ResultsByCountry>> getFutureBuilderPieChart() {
    return FutureBuilder<List<ResultsByCountry>>(
      future: _futureResultsByCountry,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getPieChart(snapshot.data);
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
    return getFutureBuilderPieChart();
  }
}
