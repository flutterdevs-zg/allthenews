import 'package:allthenews/ui/pages/news_list/primary_news_list_entity.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const double newsImageRadius = 15;
  static const double newsImageLayerOpacity = 0.7;
  static const double authorImageRadius = 15;
  static const double authorRightPadding = 8;
  static const double stackItemPadding = 20;
}

class PrimaryNewsListItem extends StatelessWidget {
  final PrimaryNewsListEntity news;

  PrimaryNewsListItem({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(_Constants.newsImageRadius),
            child: Container(
              color: Colors.black,
              child: Opacity(
                opacity: _Constants.newsImageLayerOpacity,
                child: Image.network(
                  news.imageUrl,
                  //FIXME enter correct dimensions when filling a list with those items
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 1,
            child: _buildBookmarkIcon(),
          ),
          _buildNewsInfo(context),
        ],
      );

  Positioned _buildNewsInfo(BuildContext context) => Positioned(
        bottom: 1,
        left: 1,
        child: Padding(
          padding: const EdgeInsets.all(_Constants.stackItemPadding),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildNewsTitle(context),
                SizedBox(
                  height: 15,
                ),
                _buildNewsAuthor(context),
              ],
            ),
          ),
        ),
      );

  Row _buildNewsAuthor(BuildContext context) => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: _Constants.authorRightPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_Constants.authorImageRadius),
              child: Image.network(
                news.authorImageUrl,
                //FIXME enter correct dimensions when filling a list with those items
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            news.authorName,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ],
      );

  Container _buildNewsTitle(BuildContext context) => Container(
        //FIXME enter correct dimensions when filling a list with those items
        width: 270,
        child: Column(
          children: <Widget>[
            Text(
              news.title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
              maxLines: 3,
            ),
          ],
        ),
      );

  Padding _buildBookmarkIcon() => Padding(
        padding: const EdgeInsets.all(_Constants.stackItemPadding),
        child: Icon(
          Icons.bookmark,
          color: Colors.white,
        ),
      );
}
