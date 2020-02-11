import 'package:flutter/material.dart';
import 'package:inksy/components/footer-navigator/footer-navigator.dart';
import 'package:inksy/pages/create-font.dart';
import 'package:inksy/pages/home.dart';
import 'package:inksy/pages/search.dart';
import 'package:inksy/styles/colours.dart';

class MainContent extends StatefulWidget {
  @override
  State createState() {
    return _MainContentState();
  }
}

class _MainContentState extends State {
  Widget _child;

  @override
  void initState() {
    _child = Home();
    super.initState();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colours.background,
        extendBody: true,
        body: Container(
          child: SafeArea(
              left: true, right: true, top: true, bottom: false, child: _child),
          decoration: BoxDecoration(color: Colours.background),
        ),
        bottomNavigationBar: FooterNavigator(
          height: 55.0,
          color: Colours.primary,
          buttonBackgroundColor: Colours.primary,
          backgroundColor: Colours.background,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colours.backgroundHighlight),
            Icon(Icons.search, size: 30, color: Colours.backgroundHighlight),
            Icon(Icons.edit, size: 30, color: Colours.backgroundHighlight),
          ],
          onTap: (index) {
            _handleNavigationChange(index);
          },
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      _child = [Home(), Search(), CreateFont()][index];
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
