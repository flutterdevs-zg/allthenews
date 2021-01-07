import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/location/location_map.dart';
import 'package:allthenews/src/ui/pages/location/location_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const errorWidgetVerticalSpacing = 10.0;
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final LocationNotifier _locationNotifier = inject<LocationNotifier>();

  @override
  void initState() {
    super.initState();
    _locationNotifier.findUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NyTimesAppBar(
        title: Strings.current.location,
        hasBackButton: true,
        backButtonAction: () => Navigator.pop(context),
      ),
      body: ChangeNotifierProvider.value(
        value: _locationNotifier,
        builder: (providerContext, child) {
          final viewState = providerContext.select((LocationNotifier notifier) => notifier.state);
          if (viewState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewState.error != null) {
            return _buildErrorContent(providerContext, viewState.error);
          } else if (viewState.location != null) {
            return LocationMap(location: viewState.location);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildErrorContent(BuildContext providerContext, LocationErrorViewEntity errorViewEntity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (errorViewEntity.shouldShowRetryButton)
          RetryActionContainer(
              onRetryPressed: () => providerContext.read<LocationNotifier>().retry()),
        const SizedBox(height: _Constants.errorWidgetVerticalSpacing),
        Text(errorViewEntity.errorMessage),
      ],
    );
  }
}
