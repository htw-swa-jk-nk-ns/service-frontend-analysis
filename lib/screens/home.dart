import 'package:flutter/material.dart';
import 'package:web_app/screens/components/charts_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting-Analysis'),
      ),
      body: ChartsListView(),
    );
  }
}
