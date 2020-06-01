class Tweet {
  String id;
  String user;
  String avi;
  String text;
  bool isParent;

  Tweet(String id, String user, String avi, String text, bool isParent) {
    this.id = id;
    this.user = user;
    this.avi = avi;
    this.text = text;
    this.isParent = isParent;
  }

  Tweet.fromJson(Map json)
      : id = json['id'],
        user = json['user'],
        avi = json['img'],
        text = json['text'],
        isParent = json['parent'];

  Map toJson() {
    return {
      'id': id,
      'user': user,
      "avi": avi,
      'text': text,
      'parent': isParent
    };
  }
}
