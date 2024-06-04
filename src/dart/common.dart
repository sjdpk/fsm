// getPackageName from pubspec.yaml name:
import 'dart:io';

getPackageName() {
  try {
    final file = File("pubspec.yaml");
    final content = file.readAsStringSync();
    final lines = content.split("\n");
    for (var line in lines) {
      if (line.contains("name:")) {
        return line.split(":")[1].trim();
      }
    }
    return "";
  } catch (e) {
    return "";
  }
}

String get package => getPackageName();
const int conflictCode = 4;
