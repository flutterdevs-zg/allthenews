import 'dart:io';

String findApiStubBy(String name) => File('${_findTestDirectory()}/api_stubs/$name').readAsStringSync();

//https://github.com/flutter/flutter/issues/20907
String _findTestDirectory() {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return dir;
}
