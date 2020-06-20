import 'package:allthenews/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'api_exception.dart';

extension ExceptionExtension on Exception {
  String toErrorMessage(BuildContext context) {
    if (this is ApiException) {
      return _getCommunicationExceptionMessage(context);
    } else {
      return Strings.of(context).apiDefaultException;
    }
  }

  String _getCommunicationExceptionMessage(context) {
    if (this is UnauthorizedException) {
      return Strings.of(context).apiUnauthorizedException;
    } else if (this is ConnectionException) {
      return Strings.of(context).apiConnectionException;
    } else {
      return Strings.of(context).apiDefaultException;
    }
  }
}
