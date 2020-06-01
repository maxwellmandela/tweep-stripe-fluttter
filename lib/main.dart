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
  bool loading = true;
  bool hasError = false;

  _getTweetStripes() {
    // loader
    setState(() {
      loading = true;
    });

    API.getNewStripes().then((response) {
      setState(() {
        loading = false;
        var res = json.decode(response.body);
        Iterable list = res['tweets'];
        tweets = list.map((model) => Tweet.fromJson(model)).toList();
      });
    }).catchError((onError) {
      setState(() {
        loading = false;
        hasError = true;
      });
    });
  }

  initState() {
    super.initState();
    _getTweetStripes();
  }

  dispose() {
    super.dispose();
  }

  Widget tweetHeader(String img) {
    return Row(children: [
      Column(
        children: [
          Container(
            width: 45.0,
            height: 45.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new NetworkImage(img)),
            ),
          )
        ],
      )
    ]);
  }

  @override
  build(context) {
    if (loading) {
      return Scaffold(
          appBar: AppBar(
            title: Text("New Stripes!"),
          ),
          body: Center(child: CircularProgressIndicator()));
    }

    if (hasError) {
      return Scaffold(
          appBar: AppBar(
            title: Text("New Stripes!"),
          ),
          body: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Sorry, an error occured from our side, retry!"),
              RaisedButton(
                child: Text('Retry'),
                onPressed: () {
                  _getTweetStripes();
                },
              )
            ],
          )));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("New Stripes!"),
        ),
        body: Stack(children: <Widget>[
          ListView.builder(
            itemCount: tweets.length,
            itemBuilder: (context, index) {
              return Card(
                  color: tweets[index].isParent
                      ? Colors.red[50]
                      : Colors.grey[100],
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        Column(children: [
                          tweetHeader(tweets[index].avi),
                        ]),
                        SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("@${tweets[index].user}"),
                                    SizedBox(height: 3),
                                    Text(tweets[index].text),
                                  ],
                                ),
                              ),
                            ]),
                      ])));
            },
          )
        ]));
  }
}
