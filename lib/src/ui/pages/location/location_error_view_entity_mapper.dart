import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/location/location_exception.dart';
import 'package:allthenews/src/ui/pages/location/location_notifier.dart';

abstract class LocationErrorViewEntityMapper {
  LocationErrorViewEntity map(LocationException locationException);
}

class LocationErrorViewEntityLocalMapper extends LocationErrorViewEntityMapper {
  @override
  LocationErrorViewEntity map(LocationException locationException) => LocationErrorViewEntity(
        shouldShowRetryButton: locationException is! PermissionDeniedForeverException,
        errorMessage: _resolveErrorMessage(locationException),
      );

  String _resolveErrorMessage(LocationException exception) {
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
