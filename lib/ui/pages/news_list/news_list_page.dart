import 'package:allthenews/ui/common/util/dimens.dart';
import 'package:allthenews/ui/common/util/strings.dart';
import 'package:allthenews/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/ui/pages/news_list/primary_news_list_item.dart';
import 'package:allthenews/ui/pages/news_list/primary_news_list_entity.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_page.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_view.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 10.0;
}

class NewsListPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryNewsListItem(
              news: PrimaryNewsListEntity(
                imageUrl: 'https://i.picsum.photos/id/9/800/800.jpg',
                title: "New laptops seem to be stuck to the board",
                authorName: "Marek Aureliusz",
                authorImageUrl:
                    'https://www.ludoviccareme.com/files/image_211_image_fr.jpg',
                url:
                    'https://www.nytimes.com/2020/05/14/obituaries/jonathan-adewumi-dies-coronavirus.html',
              ),
            ),
            _buildSecondaryNewsSectionHeader(),
            SizedBox(height: _Constants.sectionHeaderPadding),
            SecondaryNewsListView(
              secondaryNewsListEntities:
                  secondaryNewsListEntities.take(3).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryNewsSectionHeader() => Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: Strings.newest,
              child: Text(
                Strings.newest,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            PrimaryTextButton(
              text: Strings.showAll,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondaryNewsListPage(),
                  ),
                );
              },
            ),
          ],
        ),
      );
}
