import 'package:allthenews/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../domain/communication/api_exception.dart';

extension ExceptionExtension on Exception {
  String toErrorMessage(BuildContext context) {
    if (this is ApiException) {
      return _getCommunicationExceptionMessage(context);
    } else {
      return Strings.of(context).apiUnknownException;
    }
  }

  String _getCommunicationExceptionMessage(BuildContext context) {
    if (this is UnauthorizedException) {
      return Strings
          .of(context)
          .apiUnauthorizedException;
    } else if (this is ConnectionException) {
      return Strings
          .of(context)
          .apiConnectionException;
    } else if (this is InvalidUrlException) {
      return Strings
          .of(context)
          .apiInvalidUrlException;
    } else if (this is ServerErrorException) {
      return Strings
          .of(context)
          .apiServerException;
    } else {
      return Strings
          .of(context)
          .apiUnknownException;
    }
  }
}
