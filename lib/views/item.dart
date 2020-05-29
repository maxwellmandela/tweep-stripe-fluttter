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
    if (!widget.active) {
      return Column(children: <Widget>[
        CircularProgressIndicator(),
      ]);
    }

    return Column(
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
          height: 15,
        ),
        FloatingActionButton(
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            _handleTap();
          },
        )
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
