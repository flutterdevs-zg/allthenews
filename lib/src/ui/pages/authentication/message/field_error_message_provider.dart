import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/common/error/field_error.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';

class FieldErrorMessageProvider extends MessageProvider<FieldError> {
  @override
  String getMessage(FieldError error) {
    if (error is FieldError) {
      switch (error) {
        case FieldError.isEmpty:
          return Strings.current.emptyFieldError;
      }
    }
    return Strings.current.unknownError;
  }
}
