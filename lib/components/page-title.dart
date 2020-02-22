import 'package:flutter/material.dart';
import 'package:inksy/styles/colours.dart';

class PageTitle extends StatelessWidget {
  final String titleText;

  PageTitle(this.titleText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        titleText,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 25.0,
          color: Colours.primary,
        ),
      ),
    );
  }
}
