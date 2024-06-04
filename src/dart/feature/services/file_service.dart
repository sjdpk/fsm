import 'dart:io';

import '../../common.dart';
import '../../extensions/string_extension.dart';

class FileService {
  // @desc: create directories for a feature
  // @param: featureName, name
  // @return: void
  static Future<String?> createFolder({
    required String dir,
    bool isFeature = false,
  }) async {
    String baseDir = "";
    if (isFeature) {
      baseDir = "lib/src/features/";
    }
    final path = baseDir + dir.toSnakeCase();
    // check if the directory exists or not
    if (Directory(path).existsSync()) {
      exit(conflictCode);
    }
    await Directory(path).create(recursive: true);
    return path;
  }

  // @desc: create content inside folders with file name
  // @param: path, fileName, content
  // @return: void
  static void addContentAndFile({
    String? path,
    required String fileName,
    String? content,
  }) {
    if (path == null) return;
    final String filePath = path + fileName;
    final file = File(filePath);
    if (file.existsSync()) {
      return;
    }
    if (content == null) {
      return;
    }
    file.writeAsStringSync(content);
    Process.run("dart", ["format", filePath]);
  }
}
