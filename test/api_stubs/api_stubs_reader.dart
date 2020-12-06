import 'dart:io';

String findApiStubBy(String name) => File('${Directory.current.path}/api_stubs/$name').readAsStringSync();
