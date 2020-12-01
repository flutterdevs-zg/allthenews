import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/latest/latest_news_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../common/change_notifier_test_util.dart';

class MockGetPageUseCase extends Mock implements GetPageUseCase<Article> {}

void main() {
  LatestNewsNotifier latestNewsNotifier;
  MockGetPageUseCase mockGetPageUseCase;

  setUp(() {
    mockGetPageUseCase = MockGetPageUseCase();
    latestNewsNotifier = LatestNewsNotifier(mockGetPageUseCase, SecondaryNewsViewEntityMapper());
  });

  group('notifier tests', () {
    test(
      'should emit loading state when fetching newest articles',
      () async {
        when(mockGetPageUseCase(any)).thenAnswer((_) async => []);

        latestNewsNotifier.loadFirstPage();

        expect(latestNewsNotifier.state.isLoading, true);
      },
    );

    test('should emit loaded first page of newest articles', () async {
      when(mockGetPageUseCase(any)).thenAnswer((_) async => []);

      latestNewsNotifier.verifyStateInOrder(
        latestNewsNotifier.loadFirstPage,
        [
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
          latestNewsNotifier.loadFirstPage,
          [
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
