import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/authorization/authentication_field_error.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';

class FieldErrorMessageProvider extends MessageProvider {
  @override
  String getMessage(Object error) {
    if (error is AuthenticationFieldError) {
      switch (error) {
        case AuthenticationFieldError.isEmpty:
          return Strings.current.emptyFieldError;
      }
    }
    return Strings.current.unknownError;
  }
}
