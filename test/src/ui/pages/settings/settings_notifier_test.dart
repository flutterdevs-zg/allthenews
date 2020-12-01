import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/change_notifier_test_util.dart';

class MockAppInfoRepository extends Mock implements AppInfoRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  SettingsNotifier settingsNotifier;
  MockAppInfoRepository mockAppInfoRepository;
  MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockAppInfoRepository = MockAppInfoRepository();
    mockSettingsRepository = MockSettingsRepository();
    settingsNotifier = SettingsNotifier(mockSettingsRepository, mockAppInfoRepository);
  });

  group('notifier tests', () {
    test(
      'should emit loaded settings state when fetching succeed',
      () async {
        when(mockSettingsRepository.getTheme()).thenAnswer((_) async => AppTheme.light);
        when(mockSettingsRepository.getPopularNewsCriterion()).thenAnswer((_) async => PopularNewsCriterion.emailed);
        when(mockAppInfoRepository.getAppVersion()).thenAnswer((_) async => '1.0');

        settingsNotifier.verifyStateInOrder(
          settingsNotifier.loadSettings,
          [
            () {
              expect(settingsNotifier.viewState.isLoading, false);
              expect(settingsNotifier.viewState.appVersion, equals('1.0'));
              expect(settingsNotifier.viewState.isDarkModeEnabled, false);
              expect(settingsNotifier.viewState.selectedPopularNewsCriterion, equals(PopularNewsCriterion.emailed));
            },
          ],
        );
      },
    );
  });
}
