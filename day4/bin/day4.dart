import 'dart:io';
import 'package:collection/collection.dart';

typedef Range = Set<int>;
typedef Pair = Tuple<Range, Range>;

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple(this.item1, this.item2);

  @override
  String toString() {
    // TODO: implement toString
    return "$item1, $item2";
  }
}

List<String> readFileToList(String fileName) {
  var fileInput = File(fileName).readAsLinesSync();
  return fileInput;
}

Range rangeFromList(List<int> input) {
  return {for (var i = input.first; i <= input.last; i++) i};
}

Pair stringToPair(String inputString) {
  var split = inputString
      .split(",")
      .map((e) => e.split('-').map((e) => int.tryParse(e) ?? -1).toList())
      .toList();
  Range r1 = rangeFromList(split.first);
  Range r2 = rangeFromList(split.last);
  return Pair(r1, r2);
}

List<Pair> convertInputToRanges(List<String> input) {
  return input.map((e) => stringToPair(e)).toList();
}

Function setEquality = SetEquality<int>().equals;

int findNumberOfContainingRanges(List<Pair> ranges) {
  return ranges.where((element) {
    var intersection = element.item1.intersection(element.item2);
    return setEquality(intersection, element.item1) ||
        setEquality(intersection, element.item2);
  }).length;
}

int findNumberOfIntersections(List<Pair> ranges) {
  return ranges.where((element) {
    return element.item1.intersection(element.item2).isNotEmpty;
  }).length;
}

void part1(List<String> input) {
  var ranges = convertInputToRanges(input);
  print("Part1: ${findNumberOfContainingRanges(ranges)}");
}

void part2(List<String> input) {
  var ranges = convertInputToRanges(input);
  print("Part2: ${findNumberOfIntersections(ranges)}");
}

void main(List<String> arguments) {
  var input = readFileToList("input.txt");
  part1(input);
  part2(input);
}
