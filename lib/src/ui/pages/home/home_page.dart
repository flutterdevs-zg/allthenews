import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/exception_extensions.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/home/news/news_list_page.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_view.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_item.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:allthenews/src/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const appBarActionsVerticalPadding = 11.0;
  static const appBarActionsIconsPadding = 8.0;
  static const appBarTitleFontFamily = 'Chomsky';
  static const appBarTitleLeftPadding = 10.0;
  static const sectionHeaderPadding = 10.0;
  static const sectionSpacing = 20.0;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NYTimesRepository _nyTimesRepository = inject<NYTimesRepository>();
  final ExceptionMapper _exceptionMapper = inject<ExceptionMapper>();
  Future<List<Article>> _articleFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: _Constants.sectionHeaderPadding),
                    _buildNewsSectionHeader(
                      title: Strings.of(context).mostViewed,
                      routeBuilder: (context) => NewsListPage(
                        headerTitle: Strings.of(context).mostViewed,
                        listEntities: primaryNewsListEntities.toSecondaryNewsListEntities(),
                      ),
                    ),
                    const SizedBox(height: _Constants.sectionHeaderPadding),
                    PrimaryNewsListView(
                      primaryNewsListEntities: primaryNewsListEntities.take(5).toList(),
                    ),
                    const SizedBox(height: _Constants.sectionSpacing),
                    _buildNewsSectionHeader(
                      title: Strings.of(context).newest,
                      routeBuilder: (context) => NewsListPage(
                        headerTitle: Strings.of(context).newest,
                        listEntities: secondaryNewsListEntities,
                      ),
                    ),
                    const SizedBox(height: _Constants.sectionHeaderPadding),
                    _buildSecondaryNewsItems(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: Dimens.appBarElevation,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: const EdgeInsets.only(left: _Constants.appBarTitleLeftPadding),
        //FIXME kliknięcie wykonuje request sieciowy, do testowania blędow
        child: _buildClickableTitle(context),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: _Constants.appBarActionsVerticalPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.search,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: _Constants.appBarActionsVerticalPadding,
            bottom: _Constants.appBarActionsVerticalPadding,
            right: Dimens.pagePadding,
            left: _Constants.appBarActionsIconsPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => inject<SettingsNotifier>(),
                    child: SettingsPage(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildClickableTitle(BuildContext context) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontFamily: _Constants.appBarTitleFontFamily,
          ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _articleFuture = _nyTimesRepository.getArticles();
          });
        },
        child: _articleFuture == null
            ? const Text(UntranslatableStrings.newYorkTimes)
            : FutureBuilder<List<Article>>(
                future: _articleFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    final exception = _exceptionMapper.toExceptionType(snapshot.error);
                    return Text(exception.toErrorMessage(context));
                  } else if (snapshot.hasData) {
                    final articles = snapshot.data;
                    return Text(articles.first.toString());
                  } else {
                    return const Text(UntranslatableStrings.newYorkTimes);
                  }
                },
              ),
      ),
    );
  }

  Widget _buildNewsSectionHeader({
    @required String title,
    @required WidgetBuilder routeBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Hero(
              tag: title,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          PrimaryTextButton(
            text: Strings.of(context).showAll,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: routeBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryNewsItems() => Column(
        children: secondaryNewsListEntities
            .take(3)
            .toList()
            .map((news) => SecondaryNewsListItem(news: news))
            .toList(),
      );
}

extension on List<PrimaryNewsListEntity> {
  List<SecondaryNewsListEntity> toSecondaryNewsListEntities() => map(
        (primaryEntity) => SecondaryNewsListEntity(
          title: primaryEntity.title,
          date: primaryEntity.date,
          imageUrl: primaryEntity.imageUrl,
          time: primaryEntity.time,
          articleUrl: primaryEntity.articleUrl,
        ),
      ).toList();
}
