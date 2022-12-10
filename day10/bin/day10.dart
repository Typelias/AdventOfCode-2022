import 'dart:io';

import 'package:more/more.dart';

class Instruction {
  int add;
  int cycles;

  Instruction(this.add, this.cycles);

  @override
  String toString() {
    return "Add: $add, Cycles: $cycles";
  }
}

List<String> readInputList(String fileName) {
  return File(fileName).readAsLinesSync();
}

Instruction parseInput(String instruction) {
  if (instruction[0] == "n") {
    return Instruction(0, 1);
  }
  var split = instruction.split(' ');
  var add = int.parse(split.last);

  return Instruction(add, 2);
}

typedef Display = List<List<int>>;

void main(List<String> arguments) {
  var input =
      readInputList("input.txt").reversed.map((e) => parseInput(e)).toList();

  Instruction currentInstruction = Instruction(0, 0);
  int register = 1;
  int sum = 0;
  int checkPoint = 19;
  int rowCheckpoint = 40;
  int cycleIndex = 0;

  Display display = [[]];

  for (var i in 0.to(240)) {
    if (input.last.cycles == 0) {
      register += input.last.add;
      input.removeLast();
      if (input.isEmpty) break;
    }
    input.last.cycles--;
    // Part 1
    if (i == checkPoint) {
      print("Cycle ${i + 1} register: $register");
      sum += (i + 1) * register;
      if (checkPoint != 220) checkPoint += 40;
    }
    //Part 2
    if (i == rowCheckpoint) {
      display.add([]);
      rowCheckpoint += 40;
      if (rowCheckpoint > 240) break;
      cycleIndex = 0;
    }

    if ((register - 1).to(register + 2).contains(cycleIndex)) {
      display.last.add(1);
    } else {
      display.last.add(0);
    }
    cycleIndex++;
  }
  print(sum);
  display
      .map((e) => e.map((e) => e == 0 ? '.' : '#').join())
      .forEach((element) => print(element));
}
