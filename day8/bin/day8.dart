import 'dart:io';

import 'package:more/more.dart';

typedef Grid = List<List<Tree>>;

class Tree {
  bool visible;
  int height;
  Tree(this.height, this.visible);

  @override
  String toString() {
    return "$height, $visible";
  }
}

void printGrid() {
  for (var row in grid) {
    print(row.map((e) => e.height).toList());
  }
  print("");
  for (var row in grid) {
    print(row.map((e) => e.visible ? 1 : 0).toList());
  }
}

Grid readInputToGrid(String fileName) {
  return File(fileName)
      .readAsLinesSync()
      .map((e) => e.split('').map((e) => Tree(int.parse(e), false)).toList())
      .toList();
}

var grid = readInputToGrid("input.txt");

int checkTree(int row, int col, int height) {
  if (grid[row][col].height > height) {
    height = grid[row][col].height;
    grid[row][col].visible = true;
  }

  return height;
}

bool isInBounds(int r, int c) =>
    r >= 0 && r < grid.length && c >= 0 && c < grid.first.length;

var directions = [
  [0, 1],
  [0, -1],
  [1, 0],
  [-1, 0]
];

List<int> viewsFromTree(List<int> rc) {
  var row = rc[0], col = rc[1];
  var height = grid[row][col].height;
  List<int> values = [];

  for (var dir in directions) {
    var hr = row, hc = col;
    var val = 0;
    while (true) {
      hr += dir[0];
      hc += dir[1];
      if (!isInBounds(hr, hc)) break;
      val += 1;
      if (grid[hr][hc].height >= height) break;
    }
    values.add(val);
  }

  return values;
}

void main(List<String> arguments) {
  // Part 1
  var nRows = grid.length;
  var nCols = grid.first.length;

  for (var row in 0.to(nRows)) {
    0.to(nCols).fold(-99, (height, col) => checkTree(row, col, height));
    0
        .to(nCols)
        .reversed
        .fold(-99, (height, col) => checkTree(row, col, height));
  }

  for (var col in 0.to(nCols)) {
    0.to(nRows).fold(-99, (height, row) => checkTree(row, col, height));
    0
        .to(nRows)
        .reversed
        .fold(-99, (height, row) => checkTree(row, col, height));
  }

  print(grid
      .expand((element) => element)
      .where((element) => element.visible)
      .length);

  // Part 2
  var pairs = [
    for (var row in 0.to(grid.length))
      for (var col in 0.to(grid.first.length)) [row, col]
  ];

  var distances = pairs
      .map((e) => viewsFromTree(e).reduce((value, element) => value * element))
      .toList();

  print(distances.max());
}
