import 'package:flutter/material.dart';

class Request {
  final String path;
  final Map<String, String> queryParameters;

  Request({@required this.path, this.queryParameters});
}
