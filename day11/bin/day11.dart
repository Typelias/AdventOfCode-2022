import 'dart:io';

import 'package:more/more.dart';

class Monkey {
  List<int> items;
  String operationToken;
  String operationValue;
  int testNumber;
  int inspectionCount = 0;
  int trueAction;
  int falseAction;

  Monkey({
    required this.operationToken,
    required this.operationValue,
    required this.testNumber,
    required this.trueAction,
    required this.falseAction,
    required this.items,
  });

  int getWorryLevel(int baseLevel) {
    var value = operationValue == 'old' ? baseLevel : int.parse(operationValue);
    switch (operationToken) {
      case '*':
        return baseLevel * value;
      case '+':
        return baseLevel + value;
      case '-':
        return baseLevel - value;
      case '/':
        return baseLevel ~/ value;
    }
    return -1;
  }

  @override
  String toString() {
    return """
    Items: $items,
    Token: $operationToken,
    Value: $operationValue,
    Test: $testNumber,
    True Action: $trueAction,
    False Action: $falseAction,
    Inspection: $inspectionCount,
""";
  }
}

List<Monkey> readInput(String fileName) {
  return File(fileName).readAsStringSync().split("\n\n").map((e) {
    var split = e.split('\n');
    split.removeAt(0);
    split = split.reversed.toList();
    var items = split
        .removeLast()
        .split(':')
        .last
        .replaceAll(',', '')
        .trim()
        .split(' ')
        .map((e) => int.parse(e))
        .toList();
    var operation = split.removeLast().split('= old').last.trim();
    var token = operation[0];
    var value = operation.split(' ').last;
    var test = int.parse(split.removeLast().split(' ').last);
    var trueAction = int.parse(split.removeLast().split(' ').last);
    var falseAction = int.parse(split.removeLast().split(' ').last);

    return Monkey(
      operationToken: token,
      operationValue: value,
      testNumber: test,
      falseAction: falseAction,
      items: items,
      trueAction: trueAction,
    );
  }).toList();
}

void part1(List<Monkey> monkeyList) {
  for (var _ in 0.to(20)) {
    for (var monkey in monkeyList) {
      for (var item in monkey.items) {
        monkey.inspectionCount++;
        var worryLevel = monkey.getWorryLevel(item);
        worryLevel = (worryLevel / 3).floor();
        if (worryLevel % monkey.testNumber == 0) {
          monkeyList[monkey.trueAction].items.add(worryLevel);
        } else {
          monkeyList[monkey.falseAction].items.add(worryLevel);
        }
      }
      monkey.items = [];
    }
  }

  var part1 = monkeyList
      .map((e) => e.inspectionCount)
      .toSortedList()
      .reversed
      .take(2)
      .fold(1, (previousValue, element) => previousValue * element);
  print(part1);
}

void part2(List<Monkey> monkeyList) {
  var minCommonMulti = 1;

  for (var monkey in monkeyList) {
    minCommonMulti *= monkey.testNumber;
  }

  for (var _ in 0.to(10000)) {
    for (var monkey in monkeyList) {
      for (var item in monkey.items) {
        monkey.inspectionCount++;
        var worryLevel = monkey.getWorryLevel(item);
        worryLevel = worryLevel % minCommonMulti;
        if (worryLevel % monkey.testNumber == 0) {
          monkeyList[monkey.trueAction].items.add(worryLevel);
        } else {
          monkeyList[monkey.falseAction].items.add(worryLevel);
        }
      }
      monkey.items = [];
    }
  }

  var part2 = monkeyList
      .map((e) => e.inspectionCount)
      .toSortedList()
      .reversed
      .take(2)
      .fold(1, (previousValue, element) => previousValue * element);
  print(part2);
}

void main(List<String> arguments) {
  var monkeyList = readInput("input.txt");
  //part1(monkeyList);
  part2(monkeyList);
}

extension on List<Monkey> {
  void nicePrint() {
    for (var mapEntry in this.asMap().entries) {
      print(mapEntry.key);
      print(mapEntry.value);
      print("");
    }
  }
}
