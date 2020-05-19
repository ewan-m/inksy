import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SvgFontGenerator {
  final Map<String, List<Offset>> letterCoordinates;
  final double existingFontBoxSize = 2048;
  double customFontBoxSize = 0;

  SvgFontGenerator({this.letterCoordinates}) {
    this.calculateBoundarySize();
    this.scaleCoordinates();
  }

  void calculateBoundarySize() {
    double biggestDifference = 0;
    this.letterCoordinates.forEach((letter, coordinates) {
      Iterable<double> x = coordinates.map((e) => e != null ? e.dx : null);
      Iterable<double> y = coordinates.map((e) => e != null ? e.dy : null);
      double maxX = x.reduce(max);
      double minX = x.reduce(min);
      double maxY = y.reduce(max);
      double minY = y.reduce(min);

      if (maxX - minX > biggestDifference) {
        biggestDifference = maxX - minX;
      }
      if (maxY - minY > biggestDifference) {
        biggestDifference = maxY - minY;
      }
    });
    this.customFontBoxSize = biggestDifference;
  }

  void scaleCoordinates() {
    double scaleFactor = this.customFontBoxSize / this.existingFontBoxSize;
    this.letterCoordinates.map((letter, coordinates) => MapEntry(
          letter,
          coordinates.map((e) => Offset(
                e.dx * scaleFactor,
                e.dy * scaleFactor,
              )),
        ));
  }

  Future<String> transformFont() async {
    String font =
        await rootBundle.loadString('assets/fonts/Avenir-Next-Regular.svg');
    
    this.letterCoordinates.forEach((letter, coordinates) {
      var existingGlyph = getGlyph(letter, font);

      String replacementPath = "";
      for (var coordinate in coordinates) {
        if (coordinate == coordinates.first) {
          replacementPath += "M ${coordinate.dx} ${coordinate.dy} L ${coordinate.dx} ${coordinate.dy} ";
        } else if (coordinate != null) {

        } else {
          replacementPath += "M ";
        }
      }

      print(coordinates.map((e) => "${e.dy}, ${e.dx}"));
    });
    return "yep";
  }

  String getGlyph(String unicode, String font) {
    String firstChunk =
        font.substring(font.indexOf('<glyph unicode="${unicode}"'));
    return firstChunk.substring(0, firstChunk.indexOf('/>') + 2);
  }
}
