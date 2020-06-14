import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/data/communication/api/api_exception.dart';
import 'package:flutter/cupertino.dart';

class ErrorMessageProvider {
  static String provideErrorMessage(Exception exception, BuildContext context) =>
      provideErrorKey(exception, context);

  static String provideErrorKey(Exception exception, context) {
    if (exception is ApiException) {
      return _getCommunicationExceptionMessageKey(exception, context);
    } else {
      return Strings.of(context).apiExceptionUnknown;
    }
  }

  static String _getCommunicationExceptionMessageKey(ApiException exception, context) {
    switch (exception.errorType) {
      case ApiExceptionType.unauthorized:
        return Strings.of(context).apiExceptionUnauthorized;
      case ApiExceptionType.noInternetConnection:
        return Strings.of(context).apiExceptionNoInternet;
      case ApiExceptionType.defaultError:
        return Strings.of(context).apiExceptionGeneral;
      default:
        return Strings.of(context).apiExceptionUnknown;
    }
  }
}
