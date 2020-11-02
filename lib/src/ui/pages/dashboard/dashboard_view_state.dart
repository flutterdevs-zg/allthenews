import 'package:allthenews/src/ui/pages/dashboard/dashboard_view_entity.dart';

class DashboardViewState {
  final bool isLoading;
  final DashboardViewEntity viewEntity;
  final Object error;

  const DashboardViewState({this.isLoading = false, this.viewEntity, this.error});
}
