import 'package:comedown/views/stripe.dart';
import 'package:flutter/material.dart';

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  String _title = "Tweep Stripe!";

  Widget content(context) => Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.all(15),
      child: Column(children: [WelcomeWidget()]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_title)), body: content(context));
  }
}

class WelcomeWidget extends StatelessWidget {
  final Widget welcometext =
      Text("Archives of the funniest jokes, threads on the web");
  final String buttontext = "View New Stripes";

  Widget spacer(double n) => SizedBox(height: n);

  Widget button(txt, context) => RaisedButton(
        child: Text(txt),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TweetStripesWidget()));
        },
        color: Colors.red[300],
        textColor: Colors.white,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome,'),
          spacer(15),
          welcometext,
          spacer(5),
          button(buttontext, context)
        ],
      ),
    );
  }
}
