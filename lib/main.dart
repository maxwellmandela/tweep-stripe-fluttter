import 'dart:convert';
import 'package:comedown/API.dart';
import 'package:comedown/Tweet.dart';
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

  Widget tweetHeader(String img, String user) {
    return Row(children: [
      Column(
        children: [
          Container(
              width: 40.0,
              height: 40.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill, image: new NetworkImage(img))))
        ],
      ),
      SizedBox(width: 10),
      Column(
        children: [
          Text("@${user}"),
        ],
      )
    ]);
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Stripes!"),
        ),
        body: ListView.builder(
          // padding: EdgeInsets.all(15),
          itemCount: tweets.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    tweetHeader(tweets[index].avi, tweets[index].user),
                    SizedBox(height: 5),
                    Text(tweets[index].text),
                  ])),
            );
          },
        ));
  }
}
