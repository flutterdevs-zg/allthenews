import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/location/location_map.dart';
import 'package:allthenews/src/ui/pages/location/location_notifier.dart';
import 'package:allthenews/src/ui/pages/location/location_view_state.dart';
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
        backButtonAction: () => context.read<RoutePageManager>().pop(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ChangeNotifierProvider.value(
        value: _locationNotifier,
        builder: (providerContext, child) {
          final viewState = providerContext.select((LocationNotifier notifier) => notifier.state);
          if (viewState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewState.error != null) {
            return _buildErrorContent(viewState.error!);
          } else if (viewState.location != null) {
            return LocationMap(viewState.location!);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildErrorContent(LocationErrorViewEntity errorViewEntity) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.pagePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (errorViewEntity.shouldShowRetryButton)
            RetryActionContainer(
                onRetryPressed: () => _locationNotifier.findUserLocation()),
          const SizedBox(height: _Constants.errorWidgetVerticalSpacing),
          Text(errorViewEntity.errorMessage, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
