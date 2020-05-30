class Tweet {
  String id;
  String user;
  String text;

  Tweet(String id, String user, String text) {
    this.id = id;
    this.user = user;
    this.text = text;
  }

  Tweet.fromJson(Map json)
      : id = json['id'],
        user = json['user'],
        text = json['text'];

  Map toJson() {
    return {'id': id, 'user': user, 'text': text};
  }
}
