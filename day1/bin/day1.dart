import 'dart:io';
import 'dart:math';

class Elf {
  List<int> food;
  Elf(this.food);
}

String readFileToString(String fileName) {
  return File(fileName).readAsStringSync();
}

List<Elf> formatInput(String input) {
  List<Elf> list = [Elf([])];

  var split = input.split("\n");
  split.forEach((element) {
    var number = int.tryParse(element);
    if (number != null) {
      list.last.food.add(number);
    } else {
      list.add(Elf([]));
    }
  });

  return list;
}

List<int> getSumOfFood(List<Elf> elves) {
  List<int> sums = [];
  for (var elf in elves) {
    var sum = elf.food.fold(0, (p, e) => p + e);
    sums.add(sum);
  }
  return sums;
}

int getLargestNumber(List<Elf> elves) {
  return getSumOfFood(elves).reduce(max);
}

void part1() {
  var inputString = readFileToString("input.txt");
  var elves = formatInput(inputString);
  print("Part 1: ${getLargestNumber(elves)}");
}

void part2() {
  var inputString = readFileToString("input.txt");
  var elves = formatInput(inputString);
  var calories = getSumOfFood(elves);
  calories.sort(((a, b) => b.compareTo(a)));
  var sumOfTopThree = calories.sublist(0, 3).fold(0, (p, e) => p + e);
  print("Part 2: $sumOfTopThree");
}

void main() {
  part1();
  part2();
}
