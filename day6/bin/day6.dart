import 'dart:io';

String readInputFromFile(String inputFile) {
  return File(inputFile).readAsStringSync();
}

bool isUnique(List<String> list) {
  return list.toSet().length == list.length;
}

void getMessageMarker(int numberOfCharacters) {
  var input = readInputFromFile("input.txt").split('');
  List<String> list = [];
  int index = 0;

  for (var i in input.asMap().keys) {
    index = i;
    list.add(input[i]);
    if (isUnique(list.reversed.take(numberOfCharacters).toList()) &&
        list.length >= numberOfCharacters) break;
  }
  print(index + 1);
}

void main(List<String> arguments) {
  getMessageMarker(4);
  getMessageMarker(14);
}
