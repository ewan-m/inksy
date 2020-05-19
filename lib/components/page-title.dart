import 'package:flutter/material.dart';
import 'package:inksy/styles/colours.dart';

class PageTitle extends StatelessWidget {
  final String titleText;
  final String subtitle;

  PageTitle(this.titleText, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontFamily: 'Graphik',
              fontSize: 30.0,
              color: Colours.black,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colours.black),
          )
        ],
      ),
    );
  }
}
