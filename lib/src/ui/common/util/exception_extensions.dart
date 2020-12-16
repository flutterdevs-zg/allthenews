import 'package:allthenews/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../domain/communication/api_exception.dart';

extension ExceptionExtension on Exception {
  String toErrorMessage(BuildContext context) {
    if (this is ApiException) {
      return _getCommunicationExceptionMessage(context);
    } else {
      return Strings.current.unknownError;
    }
  }

  String _getCommunicationExceptionMessage(BuildContext context) {
    if (this is UnauthorizedException) {
      return Strings.current.apiUnauthorizedException;
    } else if (this is ConnectionException) {
      return Strings.current.noInternetException;
    } else if (this is InvalidUrlException) {
      return Strings.current.apiInvalidUrlException;
    } else if (this is ServerErrorException) {
      return Strings.current.apiServerException;
    } else {
      return Strings.current.unknownError;
    }
  }
}
