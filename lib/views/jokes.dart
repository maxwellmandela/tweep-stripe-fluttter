import 'dart:async';
import 'dart:convert';

import 'package:comedown/views/item.dart';
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

//---------------------------- JokeWidget ----------------------------
class JokeWidget extends StatefulWidget {
  @override
  _JokeWidgetState createState() => _JokeWidgetState();
}

class _JokeWidgetState extends State<JokeWidget> {
  bool _active = false;

  Future<Joke> futureJoke;
  String setup = "Not fetched yet";
  String punchline = "Tap to fetch";
  bool hasData = false;
  bool hasError = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
      hasData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    futureJoke = fetchJoke();

    return FutureBuilder<Joke>(
      future: futureJoke,
      builder: (context, snapshot) {
        print("\nFETCHING..\n");
        print(snapshot.data);
        print("\n");
        print(_active);

        if (snapshot.hasData) {
          hasData = true;
          _active = true;
        } else if (snapshot.hasError) {
          _active = false;
          hasError = true;
        }

        if (hasData) {
          setup = snapshot.data.setup;
          punchline = snapshot.data.punchline;

          return Container(
            child: SingleItem(
              active: _active,
              onChanged: _handleTapboxChanged,
              setup: setup,
              punchline: punchline,
            ),
          );
        } else if (hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
