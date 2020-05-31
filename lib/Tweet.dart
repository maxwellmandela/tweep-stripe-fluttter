class Tweet {
  String id;
  String user;
  String avi;
  String text;

  Tweet(String id, String user, String avi, String text) {
    this.id = id;
    this.user = user;
    this.avi = avi;
    this.text = text;
  }

  Tweet.fromJson(Map json)
      : id = json['id'],
        user = json['user'],
        avi = json['img'],
        text = json['text'];

  Map toJson() {
    return {'id': id, 'user': user, "avi": avi, 'text': text};
  }
}
