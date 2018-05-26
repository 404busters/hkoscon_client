import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Store {
  const Store();
  Future<String> get _appPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getFile(String filename) async {
    final path = await _appPath;
    return new File('$path/$filename');
  }

  Future<File> writeFile(String filename, String content) async {
    final file = await this.getFile(filename);
    final result = file.writeAsString(content);
    return result;
  }

  Future<String> readFile(String filename) async {
    final file = await this.getFile(filename);
    final result = file.readAsString();
    return result;
  }
}