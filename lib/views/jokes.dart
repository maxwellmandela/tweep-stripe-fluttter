import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Joke> fetchJoke() async {
  final response = await http
      .get('https://official-joke-api.appspot.com/jokes/programming/random');

  if (response.statusCode == 200) {
    return Joke.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load Joke');
  }
}

class Joke {
  final int id;
  final String setup;
  final String type;
  final String punchline;

  Joke({this.id, this.type, this.setup, this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }
}

class JokesWidget extends StatefulWidget {
  JokesWidget({Key key}) : super(key: key);

  @override
  _JokesWidgetState createState() => _JokesWidgetState();
}

class SingleJokeWidget extends StatefulWidget {
  bool isFetchingJokes;
  Function(bool) callback;
  SingleJokeWidget(this.isFetchingJokes, this.callback);

  @override
  _SingleJokeWidgetState createState() => _SingleJokeWidgetState();
}

class _SingleJokeWidgetState extends State<SingleJokeWidget> {
  Future<Joke> futureJoke;
  String setup;
  String punchline;
  bool hasData;
  bool hasError;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke();
    hasData = false;
    hasError = false;
    setup = "Waiting to happe";
    punchline = "A bad bad joke";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Joke>(
      future: futureJoke,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          hasData = true;
          setup = snapshot.data.setup;
          punchline = snapshot.data.punchline;
        } else if (snapshot.hasError) {
          hasError = snapshot.hasError;
        }

        if (hasData) {
          widget.callback(false);

          return Column(children: [
            Text(setup),
            SizedBox(height: 10),
            Text(punchline),
            SizedBox(height: 20)
          ]);
        } else if (hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class _JokesWidgetState extends State<JokesWidget> {
  bool isFetchingJokes = true;
  String response = "Fetching";

  callback(status) {
    setState(() {
      isFetchingJokes = status;
      response = isFetchingJokes ? "Fetching" : "Fetch Another!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      new SingleJokeWidget(isFetchingJokes, callback),
      RaisedButton(
        onPressed: null,
        child: Text(response),
      )
    ]);
  }
}
