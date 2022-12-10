import 'dart:io';

class Instruction {
  int amount;
  int from;
  int destination;
  Instruction(this.amount, this.from, this.destination);

  static Instruction parseInstruction(String input) {
    List<String> split = input.split(" ");
    int amount = int.parse(split[1]);
    int from = int.parse(split[3]) - 1;
    int destination = int.parse(split[5]) - 1;
    return Instruction(amount, from, destination);
  }
}

var stacks = [
  "RGHQSBTN",
  "HSFDPZJ",
  "ZHV",
  "MZJFGH",
  "TZCDLMSR",
  "MTWVHZJ",
  "TFPLZ",
  "QVWS",
  "WHLMTDNC"
];

List<String> readFileInput(String inputFile) {
  return File(inputFile).readAsLinesSync();
}

//PTWLTDSJV
void part1(List<Instruction> instructions) {
  for (var i in instructions) {
    var crates = stacks[i.from]
        .substring(stacks[i.from].length - i.amount)
        .split('')
        .reversed
        .join();
    stacks[i.destination] += crates;
    stacks[i.from] =
        stacks[i.from].substring(0, stacks[i.from].length - i.amount);
  }
  print(stacks.map((e) => e[e.length - 1]).join());
}

// WZMFVGGZP
void part2(List<Instruction> instructions) {
  for (var i in instructions) {
    var crates = stacks[i.from].substring(stacks[i.from].length - i.amount);
    stacks[i.destination] += crates;
    stacks[i.from] =
        stacks[i.from].substring(0, stacks[i.from].length - i.amount);
  }
  print(stacks.map((e) => e[e.length - 1]).join());
}

void main(List<String> args) {
  var input = readFileInput("input.txt");
  var instructions = input.map((e) => Instruction.parseInstruction(e)).toList();
  // part1(instructions);
  part2(instructions);
}
