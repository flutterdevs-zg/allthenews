import 'package:allthenews/ui/pages/news_list/primary_news_list_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const imageRadius = 15.0;
  static const newsImageLayerOpacity = 0.7;
  static const authorDataSpacing = 10.0;
  static const stackItemPadding = 20.0;
  static const wrappingThresholdPercent = 0.65;
}

class PrimaryNewsListItem extends StatelessWidget {
  final PrimaryNewsListEntity news;

  PrimaryNewsListItem({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(_Constants.imageRadius),
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
          top: 0,
          right: 0,
          child: _buildBookmarkIcon(),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: _buildNewsInfo(context),
        ),
      ],
    );
  }

  Widget _buildNewsInfo(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(_Constants.stackItemPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNewsTitle(context),
            SizedBox(
              height: 15,
            ),
            _buildNewsAuthor(context),
          ],
        ),
      );

  Widget _buildNewsAuthor(BuildContext context) =>
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_Constants.imageRadius),
            child: Image.network(
              news.authorImageUrl,
              //FIXME enter correct dimensions when filling a list with those items
              width: 40,
              height: 40,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: _Constants.authorDataSpacing,
          ),
          Text(
            news.authorName,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      );

  Widget _buildNewsTitle(BuildContext context) {
    var wrappingThreshold = MediaQuery
        .of(context)
        .size
        .width * _Constants.wrappingThresholdPercent;

    return Container(
      width: wrappingThreshold,
      child: Column(
        children: [
          Text(
            news.title,
            style: Theme
                .of(context)
                .textTheme
                .subtitle1
                .copyWith(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkIcon() =>
      Padding(
        padding: const EdgeInsets.all(_Constants.stackItemPadding),
        child: Icon(
          Icons.bookmark,
          color: Colors.white,
        ),
      );
}
