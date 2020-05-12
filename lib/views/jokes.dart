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

class _JokesWidgetState extends State<JokesWidget> {
  Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Joke>(
      future: futureJoke,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(children: [
            Text(snapshot.data.setup),
            SizedBox(height: 10),
            Text(snapshot.data.punchline),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                setState(() {
                  futureJoke = fetchJoke();
                });
              },
              child: Text('Fetch Another!'),
            ),
          ]);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
