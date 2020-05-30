import 'package:flutter/material.dart';

class SingleItem extends StatefulWidget {
  SingleItem(
      {Key key,
      this.active,
      this.setup,
      this.punchline,
      @required this.onChanged})
      : super(key: key);

  final bool active;
  final String setup;
  final String punchline;
  final ValueChanged<bool> onChanged;

  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  void _handleTap() {
    widget.onChanged(false);
  }

  Widget jokeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.setup,
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          widget.punchline,
        ),
        SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              ],
            ),
            Column(children: <Widget>[
              FloatingActionButton(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  _handleTap();
                },
              )
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.all(15),
      child: jokeContent(),
    );
  }
}
