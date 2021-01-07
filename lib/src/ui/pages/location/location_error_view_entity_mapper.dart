import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/location/location_exception.dart';
import 'package:allthenews/src/ui/pages/location/location_view_state.dart';

abstract class LocationErrorViewEntityMapper {
  LocationErrorViewEntity map(Exception exception);
}

class LocationErrorViewEntityLocalMapper extends LocationErrorViewEntityMapper {
  @override
  LocationErrorViewEntity map(Exception exception) => LocationErrorViewEntity(
        shouldShowRetryButton: exception is! PermissionDeniedForeverException,
        errorMessage: _resolveErrorMessage(exception),
      );

  String _resolveErrorMessage(Exception exception) {
    if (exception is PermissionDeniedForeverException) {
      return Strings.current.permissionDeniedForeverErrorMessage;
    } else if (exception is PermissionDeniedException) {
      return Strings.current.permissionDeniedErrorMessage;
    } else if (exception is LocationServiceDisabledException) {
      return Strings.current.locationServiceDisabledErrorMessage;
    }

    return Strings.current.unknownError;
  }
}
