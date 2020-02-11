import 'package:flutter/material.dart';
import 'package:inksy/styles/colours.dart';

class LetterButton extends StatefulWidget {
  final String letter;
  final ValueChanged<String> onTap;
  final bool visited;
  final bool current;

  LetterButton({this.letter, this.visited, this.current, this.onTap});

  @override
  State<StatefulWidget> createState() {
    return LetterButtonState();
  }
}

class LetterButtonState extends State<LetterButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.current ? 100.0 : 50.0,
      height: widget.current ? 100.0 : 70.0,
      margin: EdgeInsets.symmetric(
          horizontal: 5.0, vertical: widget.current ? 0.0 : 15.0),
      decoration: BoxDecoration(
        color: Colours.backgroundHighlight,
        borderRadius: widget.current
            ? BorderRadius.circular(5.0)
            : BorderRadius.circular(50.0),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Stack(
        children: [
          AnimatedContainer(
            height: widget.visited ? 100.0 : 0.0,
            decoration: BoxDecoration(
                borderRadius: widget.current
                    ? BorderRadius.circular(5.0)
                    : BorderRadius.circular(50.0),
                color: Colours.secondary),
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              widget.onTap(widget.letter);
            },
            child: Center(
              child: Text(
                widget.letter,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: widget.visited
                        ? Colours.backgroundHighlight
                        : Colours.secondary,
                    fontSize: 35.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
