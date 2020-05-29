import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleItem extends StatefulWidget {
  SingleItem(
      {Key key,
      this.active: false,
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
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return GestureDetector(
      onTapDown: _handleTapDown, // Handle the tap events in the order that
      onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(15),
        child: Text(widget.active ? widget.setup : widget.punchline),
        decoration: BoxDecoration(
          color: widget.active ? Colors.red[500] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.red[300],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}
