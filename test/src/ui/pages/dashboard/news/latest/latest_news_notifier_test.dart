import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/latest/latest_news_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../common/change_notifier_test_util.dart';
import 'latest_news_notifier_test.mocks.dart';

@GenerateMocks([GetPageUseCase])
void main() {
  late LatestNewsNotifier latestNewsNotifier;
  late MockGetPageUseCase<Article> mockGetPageUseCase;

  setUp(() {
    mockGetPageUseCase = MockGetPageUseCase();
    latestNewsNotifier = LatestNewsNotifier(mockGetPageUseCase, SecondaryNewsViewEntityMapper());
  });

  group('notifier tests', () {
    test('should emit loaded first page of newest articles', () async {
      when(mockGetPageUseCase(any)).thenAnswer((_) async => []);

      latestNewsNotifier.verifyStateInOrder(
        testFunction: latestNewsNotifier.loadFirstPage,
        matchersMethods: [
          () {
            expect(latestNewsNotifier.state.isLoading, true);
            expect(latestNewsNotifier.state.paginatedItems, isNull);
            expect(latestNewsNotifier.state.error, isNull);
          },
          () {
            expect(latestNewsNotifier.state.isLoading, false);
            expect(latestNewsNotifier.state.paginatedItems, isNotNull);
            expect(latestNewsNotifier.state.error, isNull);
          },
        ],
      );
    });

    test(
      'should emit error state when fetching news failed',
      () async {
        when(mockGetPageUseCase(any)).thenAnswer((_) async => Future.error(UnknownException()));

        latestNewsNotifier.verifyStateInOrder(
          testFunction: latestNewsNotifier.loadFirstPage,
          matchersMethods: [
            () {
              expect(latestNewsNotifier.state.isLoading, true);
              expect(latestNewsNotifier.state.paginatedItems, isNull);
              expect(latestNewsNotifier.state.error, isNull);
            },
            () {
              expect(latestNewsNotifier.state.isLoading, false);
              expect(latestNewsNotifier.state.paginatedItems, isNull);
              expect(latestNewsNotifier.state.error, isA<UnknownException>());
            }
          ],
        );
      },
    );
  });
}
