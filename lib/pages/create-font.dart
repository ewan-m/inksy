import 'package:flutter/material.dart';
import 'package:inksy/components/page-title.dart';
import 'package:inksy/pages/alphabet.dart';
import 'package:inksy/pages/letter-button.dart';
import 'package:inksy/pages/letter-drawer.dart';
import 'package:inksy/styles/colours.dart';

class CreateFont extends StatefulWidget {
  @override
  CreateFontState createState() => CreateFontState();
}

class CreateFontState extends State<CreateFont> with TickerProviderStateMixin {
  Map<String, List<Offset>> letters = Map.fromIterable(
    Alphabet.letters,
    key: (item) => item,
    value: (item) => <Offset>[],
  );
  Map<String, List<Offset>> limits = Map.fromIterable(
    Alphabet.letters,
    key: (item) => item,
    value: (item) => <Offset>[],
  );
  Set<String> visitedLetters = Set.of([Alphabet.letters.first]);
  String currentLetter = Alphabet.letters.first;

  bool isWithinBox(Offset drawPoint) {
    return drawPoint.dx > 0 &&
        drawPoint.dy > 0 &&
        drawPoint.dx < MediaQuery.of(context).size.width - 40.0 &&
        drawPoint.dy < MediaQuery.of(context).size.width * 1.1;
  }

  void updateMinMaxYValues(Offset newPoint) {
    if (limits[currentLetter].isEmpty) {
      limits[currentLetter].add(newPoint);
      limits[currentLetter].add(newPoint);
    } else {
      if (newPoint.dy > limits[currentLetter][1].dy) {
        limits[currentLetter][1] =
            Offset(limits[currentLetter][1].dx, newPoint.dy);
      }
      if (newPoint.dx > limits[currentLetter][1].dx) {
        limits[currentLetter][1] =
            Offset(newPoint.dx, limits[currentLetter][1].dy);
      }
      if (newPoint.dx < limits[currentLetter][0].dx) {
        limits[currentLetter][0] =
            Offset(newPoint.dx, limits[currentLetter][0].dy);
      }
      if (newPoint.dy < limits[currentLetter][0].dy) {
        limits[currentLetter][0] =
            Offset(limits[currentLetter][0].dx, newPoint.dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          PageTitle("Create Font"),
          Container(
            margin: EdgeInsets.all(20.0),
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                if (isWithinBox(details.localPosition)) {
                  setState(() {
                    updateMinMaxYValues(details.localPosition);
                    letters.update(
                      currentLetter,
                      (points) => List.from(points)..add(details.localPosition),
                    );
                  });
                }
              },
              onPanStart: (DragStartDetails details) {
                if (isWithinBox(details.localPosition)) {
                  setState(() {
                    updateMinMaxYValues(details.localPosition);
                    letters.update(
                      currentLetter,
                      (points) => List.from(points)..add(details.localPosition),
                    );
                  });
                }
              },
              onPanEnd: (DragEndDetails details) {
                setState(() {
                  visitedLetters.add(currentLetter);
                  letters.update(
                    currentLetter,
                    (points) => List.from(points)..add(null),
                  );
                });
              },
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 1.05,
                decoration: BoxDecoration(
                  color: Colours.lightestGrey,
                ),
                child: CustomPaint(
                  painter: LetterDrawer(
                    limits: limits,
                    points: letters[currentLetter],
                    currentLetter: currentLetter,
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Alphabet.letters
                  .map(
                    (e) => LetterButton(
                        letter: e,
                        visited: visitedLetters.contains(e),
                        current: e == currentLetter,
                        onTap: (newLetter) {
                          setState(() {
                            currentLetter = newLetter;
                          });
                        }),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
