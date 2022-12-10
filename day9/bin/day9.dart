import 'dart:io';
import 'package:more/more.dart';

class Pos {
  int x = 0;
  int y = 0;

  void adjust(Pos to) {
    if ((to.x - x).abs() > 1 || (to.y - y).abs() > 1) {
      x += direction(x, to.x);
      y += direction(y, to.y);
    }
  }

  @override
  bool operator ==(Object other) {
    return other is Pos && other.x == x && other.y == y;
  }

  @override
  int get hashCode {
    return 0;
  }

  Pos.fromCords(this.x, this.y);

  Pos();

  int direction(int from, int to) {
    return from == to ? 0 : (from > to ? -1 : 1);
  }

  @override
  String toString() {
    return "x: $x, y: $y";
  }
}

class Rope {
  List<Pos> knots = [];
  Set<Pos> visited = {};

  Rope(int nKnots) {
    for (var _ in 0.to(nKnots)) {
      knots.add(Pos());
    }
  }

  void move(int dx, int dy) {
    knots.first.x += dx;
    knots.first.y += dy;
    for (var i in 1.to(knots.length)) {
      knots[i].adjust(knots[i - 1]);
    }

    visited.add(Pos.fromCords(knots.last.x, knots.last.y));
  }
}

List<String> readLines(String fileName) => File(fileName).readAsLinesSync();

void main(List<String> args) {
  var rope1 = Rope(2);
  var rope2 = Rope(10);
  for (var line in readLines('input.txt')) {
    int dx = 0, dy = 0;
    var split = line.split(' ');
    var n = int.parse(split.last);
    switch (split.first) {
      case 'R':
        dx = 1;
        break;
      case 'L':
        dx = -1;
        break;
      case 'D':
        dy = 1;
        break;
      case 'U':
        dy = -1;
        break;
    }
    for (var _ in 0.to(n)) {
      rope1.move(dx, dy);
      rope2.move(dx, dy);
    }
  }

  print(rope1.visited.length);
  print(rope2.visited.length);
}
