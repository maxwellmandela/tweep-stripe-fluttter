import 'package:comedown/views/jokes.dart';
import 'package:flutter/material.dart';

class TweetStripesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Stripes"),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JokesWidget(),
              ],
            )));
  }
}
