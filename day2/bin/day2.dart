import 'dart:io';

enum Shape { rock, paper, scissors }

Shape charToChape(String char) {
  if (char == "A" || char == "X") {
    return Shape.rock;
  } else if (char == "B" || char == "Y") {
    return Shape.paper;
  }

  return Shape.scissors;
}

class Round {
  Shape oponentShape;
  Shape yourShape;
  Round(this.oponentShape, this.yourShape);

  int _getBaseScore() {
    switch (yourShape) {
      case Shape.rock:
        return 1;
      case Shape.paper:
        return 2;
      case Shape.scissors:
        return 3;
    }
  }

  int _calculateOutcomeScore() {
    if (oponentShape == yourShape) {
      return 3;
    }
    switch (oponentShape) {
      case Shape.rock:
        if (yourShape == Shape.paper) {
          return 6;
        }
        break;
      case Shape.paper:
        if (yourShape == Shape.scissors) {
          return 6;
        }
        break;
      case Shape.scissors:
        if (yourShape == Shape.rock) {
          return 6;
        }
    }

    return 0;
  }

  int calculateScore() {
    return _getBaseScore() + _calculateOutcomeScore();
  }

  void _setUpLoss() {
    switch (oponentShape) {
      case Shape.rock:
        yourShape = Shape.scissors;
        break;
      case Shape.paper:
        yourShape = Shape.rock;
        break;
      case Shape.scissors:
        yourShape = Shape.paper;
        break;
    }
  }

  void _setUpDraw() {
    yourShape = oponentShape;
  }

  void _setUpWin() {
    switch (oponentShape) {
      case Shape.rock:
        yourShape = Shape.paper;
        break;
      case Shape.paper:
        yourShape = Shape.scissors;
        break;
      case Shape.scissors:
        yourShape = Shape.rock;
        break;
    }
  }

  void fixForPart2() {
    switch (yourShape) {
      case Shape.rock:
        _setUpLoss();
        break;
      case Shape.paper:
        _setUpDraw();
        break;
      case Shape.scissors:
        _setUpWin();
        break;
    }
  }
}

String readInputFileToString(String fileName) {
  return File(fileName).readAsStringSync();
}

List<Round> formatInputString(String input) {
  List<Round> rounds = [];

  for (var element in input.split("\n")) {
    var roundInput = element.split(" ");
    if (roundInput.length != 2) continue;
    rounds.add(Round(charToChape(roundInput[0]), charToChape(roundInput[1])));
  }

  return rounds;
}

void part1() {
  var inputString = readInputFileToString("input.txt");
  var formatedInput = formatInputString(inputString);
  var totalPoint = formatedInput.fold(0, (p, e) => p + e.calculateScore());
  print("Part1: $totalPoint");
}

void part2() {
  var inputString = readInputFileToString("input.txt");
  var formatedInput = formatInputString(inputString);
  formatedInput.forEach((element) => element.fixForPart2());
  var totalPoint = formatedInput.fold(0, (p, e) => p + e.calculateScore());
  print("Part2: $totalPoint");
}

void main() {
  part1();
  part2();
}
