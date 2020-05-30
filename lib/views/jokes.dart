import 'dart:async';
import 'dart:convert';

import 'package:comedown/views/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Joke> fetchJoke() async {
  final response = await http.get('https://290b920a521f.ngrok.io/api/stripes');

  if (response.statusCode == 200) {
    return Joke.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class Joke {
  final Tweet tweet;
  final List<Tweet> replies;

  Joke({this.tweet, this.replies});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      tweet: json['tweet'],
      replies: json['replies'].map((data) => Tweet.fromJson(data)).toList(),
    );
  }
}

class Tweet {
  final String user;
  final String text;

  Tweet._({this.user, this.text});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet._(
      user: json['user'],
      text: json['text'],
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
  bool hasData = false;
  bool hasError = false;
  List<Tweet> replies;
  Future<Joke> futureJoke;
  Tweet tweet;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
      hasData = false;
    });
  }

  Widget displayError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Sorry, there was a problem, please try again"),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            _handleTapboxChanged(false);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    futureJoke = fetchJoke();

    return FutureBuilder<Joke>(
      future: futureJoke,
      builder: (context, snapshot) {
        print("\nFETCHING..\n");
        print(snapshot.data);
        print(_active);

        if (snapshot.hasData) {
          hasData = true;
          _active = true;
        } else if (snapshot.hasError) {
          _active = false;
          hasError = true;
        }

        print(snapshot.data);

        if (hasData) {
          tweet = snapshot.data.tweet;
          replies = snapshot.data.replies;

          print("Result: @${tweet.user}");

          return Container(
            child: SingleItem(
              active: _active,
              onChanged: _handleTapboxChanged,
              tweet: tweet,
              replies: replies,
            ),
          );
        } else if (hasError) {
          print("${snapshot.error}");
          return displayError();
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
