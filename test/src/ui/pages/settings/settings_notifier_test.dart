import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/change_notifier_test_util.dart';
import 'settings_notifier_test.mocks.dart';

@GenerateMocks([AppInfoRepository, SettingsRepository])
void main() {
  late SettingsNotifier settingsNotifier;
  late MockAppInfoRepository mockAppInfoRepository;
  late MockSettingsRepository mockSettingsRepository;

  setUpAll(() {
    mockAppInfoRepository = MockAppInfoRepository();
    mockSettingsRepository = MockSettingsRepository();
    settingsNotifier = SettingsNotifier(mockSettingsRepository, mockAppInfoRepository);
  });

  group('notifier tests', () {
    test(
      'should emit loaded settings state when fetching articles succeeded',
      () async {
        when(mockSettingsRepository.getTheme()).thenAnswer((_) async => AppTheme.light);
        when(mockSettingsRepository.getPopularNewsCriterion())
            .thenAnswer((_) async => PopularNewsCriterion.emailed);
        when(mockAppInfoRepository.getAppVersion()).thenAnswer((_) async => '1.0');

        settingsNotifier.verifyStateInOrder(
          testFunction: settingsNotifier.loadSettings,
          matchersMethods: [
            () {
              expect(settingsNotifier.viewState.isLoading, false);
              expect(settingsNotifier.viewState.appVersion, equals('1.0'));
              expect(settingsNotifier.viewState.isDarkModeEnabled, false);
              expect(settingsNotifier.viewState.selectedPopularNewsCriterion,
                  equals(PopularNewsCriterion.emailed));
            },
          ],
        );
      },
    );
  });
}
