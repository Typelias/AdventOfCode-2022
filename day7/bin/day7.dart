
import 'dart:io';

List<String> readLinesFromFile(String fileName) {
  return File(fileName).readAsLinesSync();
}

void main(List<String> arguments) {
  var input =  readLinesFromFile("input.txt");
  input.removeAt(0);

  var folderStructure = {'/': 0};

  var pathStack = ['/'];

  for (var command in input) {
    if(command.startsWith("\$ cd")) {
      var arg = command.split(' ')[2];
      if (arg == "..") {
        pathStack.removeLast();
      } else {
        pathStack.add('${pathStack.last}$arg/');
      }
    } else if(!command.startsWith('dir') && !command.startsWith('\$')) {
      for (var path in pathStack) {
        folderStructure.putIfAbsent(path, () => 0);
        folderStructure[path] = folderStructure[path]! + int.parse(command.split(' ')[0]);
      }
    }
  }

  var pt1 = folderStructure.values.where((element) => element <= 100000).reduce((value, element) => value + element);

  print("Part 1: $pt1");

  folderStructure = Map.fromEntries(folderStructure.entries.toList()..sort(((a, b) => a.value.compareTo(b.value))));

  var totalSpace = 70000000;
  var spaceNeeded = 30000000;
  var unusedSpace = totalSpace - folderStructure["/"]!;

  for(var folder in folderStructure.entries) {
    if (folder.value + unusedSpace >= spaceNeeded) {
      print("Part 2 ${folder.value}");
      break;
    }
  }
  
}
