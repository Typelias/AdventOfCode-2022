import 'dart:io';

List<String> getInputFromFile(String fileName) {
  return File(fileName).readAsLinesSync();
}

int charToInt(String char) {
  var arr = char.runes.toList();
  if (char.toUpperCase() == char) {
    return arr[0] - 38;
  }
  return arr[0] - 96;
}

List<String> splitInHalf(String input) {
  var halfPoint = (input.length / 2).ceil();
  return [input.substring(0, halfPoint), input.substring(halfPoint)];
}

String findChar(String input) {
  var items = splitInHalf(input);
  return items.first
      .split('')
      .firstWhere((element) => items.last.contains(element));
}

void part1() {
  var input = getInputFromFile("input.txt");
  var sum = input
      .map((e) => findChar(e))
      .map((e) => charToInt(e))
      .fold(0, (p, e) => p + e);
  print("Part1: $sum");
}

List<List<String>> partition(List<String> inputList) {
  List<List<String>> chunks = [];
  int chunksize = 3;
  for (int i = 0; i < inputList.length; i += chunksize) {
    chunks.add(inputList.sublist(i,
        i + chunksize > inputList.length ? inputList.length : i + chunksize));
  }
  return chunks;
}

String findCommonCharacter(List<String> group) {
  return group.first.split('').firstWhere(
      (element) => group[1].contains(element) && group.last.contains(element));
}

void part2() {
  var input = getInputFromFile("input.txt");
  var groups = partition(input);
  var sum = groups
      .map((e) => findCommonCharacter(e))
      .map((e) => charToInt(e))
      .fold(0, (p, e) => p + e);
  print("Part2: $sum");
}

void main(List<String> arguments) {
  part1();
  part2();
}
