import 'package:flutter/material.dart';
import 'package:inksy/components/page-title.dart';
import 'package:inksy/styles/colours.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.white,
      child: Column(children: [PageTitle("Search", "Search for shit")]),
    );
  }
}
