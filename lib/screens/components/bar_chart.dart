/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  /// Creates a [BarChart] with VoteSummary data and transition.
  factory SimpleBarChart.withVoteSummaryData(List<VoteSummary> data) {
    return new SimpleBarChart(
      _createVoteSummaryData(data),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Votes',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  /// Create one series with VoteSummary data recieved by the ServingLayer.
  static List<charts.Series<VoteSummary, String>> _createVoteSummaryData(
      List<VoteSummary> data) {
    return [
      new charts.Series<VoteSummary, String>(
        id: 'Votes',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (VoteSummary sales, _) => sales.vote,
        measureFn: (VoteSummary sales, _) => sales.count,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

/// TODO replace with JSON wrapper class later on
class VoteSummary {
  final String vote;
  final int count;

  VoteSummary(this.vote, this.count);
}
