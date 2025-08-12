import 'package:dio/dio.dart';

import '../../core/error_handling/exceptions.dart';

enum RequestMethod {
  get,
  post,
  delete,
}

extension RequestMethodExt on RequestMethod {
  String get name {
    switch (this) {
      case RequestMethod.get:
        return 'GET';
      case RequestMethod.post:
        return 'POST';
      case RequestMethod.delete:
        return 'DELETE';
    }
  }

  Options get options {
    switch (this) {
      case RequestMethod.get:
        return Options(method: name);
      case RequestMethod.post:
        return Options(method: name);
      case RequestMethod.delete:
        return Options(method: name);
    }
  }

  static RequestMethod getRequestMethodFromOptionName(String name) {
    name = name.toUpperCase();

    if (name == RequestMethod.get.name) {
      return RequestMethod.get;
    }

    if (name == RequestMethod.post.name) {
      return RequestMethod.post;
    }
    if (name == RequestMethod.delete.name) {
      return RequestMethod.delete;
    }

    throw const UnhandledException();
  }
}
