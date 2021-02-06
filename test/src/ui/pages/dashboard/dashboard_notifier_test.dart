import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/change_notifier_test_util.dart';
import 'news/fake_popular_news_criterion_message_mapper.dart';

class MockNYTimesReactiveRepository extends Mock implements NYTimesReactiveRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  DashboardNotifier dashboardNotifier;
  MockNYTimesReactiveRepository mockNYTimesReactiveRepository;
  MockSettingsRepository mockSettingsRepository;
  FakePopularNewsCriterionMessageMapper fakePopularNewsCriterionMessageMapper;

  setUp(() {
    mockNYTimesReactiveRepository = MockNYTimesReactiveRepository();
    mockSettingsRepository = MockSettingsRepository();
    fakePopularNewsCriterionMessageMapper = FakePopularNewsCriterionMessageMapper();
    dashboardNotifier = DashboardNotifier(
      mockNYTimesReactiveRepository,
      mockSettingsRepository,
      fakePopularNewsCriterionMessageMapper,
    );
  });

  group('notifier tests', () {
    test(
      'should emit loaded dashboard state when fetching articles succeeded',
      () {
        when(mockSettingsRepository.getTheme()).thenAnswer((_) async => AppTheme.light);
        when(mockSettingsRepository.getPopularNewsCriterionStream()).thenAnswer((_) => Stream.value(PopularNewsCriterion.emailed));
        when(mockNYTimesReactiveRepository.getMostPopularArticlesStream()).thenAnswer((_) => Stream.value(<Article>[]));
        when(mockNYTimesReactiveRepository.getNewestArticlesStream()).thenAnswer((_) => Stream.value(<Article>[]));

        dashboardNotifier.verifyStateInOrder(
          dashboardNotifier.fetchArticles,
          [
            () {
              expect(dashboardNotifier.state.isLoading, true);
              expect(dashboardNotifier.state.viewEntity, isNull);
              expect(dashboardNotifier.state.error, isNull);
            },
            () {
              expect(dashboardNotifier.state.isLoading, false);
              expect(dashboardNotifier.state.viewEntity, isNotNull);
              expect(dashboardNotifier.state.error, isNull);
            },
          ],
        );
      },
    );

    test(
      'should emit loaded dashboard state when fetching articles failed',
      () {
        when(mockSettingsRepository.getTheme()).thenAnswer((_) async => AppTheme.light);
        when(mockSettingsRepository.getPopularNewsCriterionStream()).thenAnswer((_) => Stream.value(PopularNewsCriterion.emailed));
        when(mockNYTimesReactiveRepository.getMostPopularArticlesStream()).thenAnswer((_) => Stream.error(UnknownException()));
        when(mockNYTimesReactiveRepository.getNewestArticlesStream()).thenAnswer((_) => Stream.value(<Article>[]));

        dashboardNotifier.verifyStateInOrder(
          dashboardNotifier.fetchArticles,
          [
            () {
              expect(dashboardNotifier.state.isLoading, true);
              expect(dashboardNotifier.state.viewEntity, isNull);
              expect(dashboardNotifier.state.error, isNull);
            },
            () {
              expect(dashboardNotifier.state.isLoading, false);
              expect(dashboardNotifier.state.viewEntity, isNull);
              expect(dashboardNotifier.state.error, isNotNull);
            },
          ],
        );
      },
    );
  });
}
