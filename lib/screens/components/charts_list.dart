import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_app/screens/components/chart_candidate.dart';
import 'package:web_app/screens/components/chart_country.dart';

class ChartsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    List<String> titles = ['By Candidate', 'By Country'];
    return ListView.separated(
      itemCount: 2,
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 2.0,
      ),
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(titles[index]),
            //--> true charts are placed here
            subtitle: index == 0
                ? _buildChartCandidate(context)
                : _buildChartCountry(context));
      },
    );
  }

  Widget _buildChartCandidate(BuildContext context) {
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              ///TODO add chart for candidate
              child: CandidateBarChart(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChartCountry(BuildContext context) {
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              ///TODO add chart for country
              child: CountryBarChart(),
            )
          ],
        ),
      ),
    );
  }
}
