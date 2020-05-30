import 'dart:convert';
import 'package:comedown/API.dart';
import 'package:comedown/User.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tweep Stripes!',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var tweets = new List<Tweet>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)['replies'];
        tweets = list.map((model) => Tweet.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Stripes!"),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: tweets.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("@${tweets[index].user}"),
              subtitle: Text(tweets[index].text),
              contentPadding: EdgeInsets.all(2),
              onTap: null,
            );
          },
        ));
  }
}
