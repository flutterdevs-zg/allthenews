import 'dart:io';

String findApiStubBy(String name) => File('${Directory.current.path}/test/api_stubs/$name').readAsStringSync();
