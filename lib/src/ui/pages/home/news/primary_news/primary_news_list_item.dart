import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/web_view/web_view_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const imageRadius = 15.0;
  static const authorImageSize = 40.0;
  static const newsImageLayerOpacity = 0.7;
  static const authorDataSpacing = 10.0;
  static const stackItemPadding = 20.0;
  static const wrappingThresholdPercent = 0.50;
  static const horizontalListItemPadding = 13.0;
  static const itemSplashColor = Color(0x1FD5D5D5);
  static const itemHighlightColor = Color(0x2DD5D5D5);
}

class PrimaryNewsListItem extends StatelessWidget {
  final PrimaryNewsListEntity news;

  PrimaryNewsListItem({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _Constants.horizontalListItemPadding,
      ),
      child: Stack(
        children: [
          _buildImage(),
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
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_Constants.imageRadius),
              child: Opacity(
                opacity: _Constants.newsImageLayerOpacity,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: _Constants.itemSplashColor,
                    highlightColor: _Constants.itemHighlightColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(url: news.articleUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage() => ClipRRect(
        borderRadius: BorderRadius.circular(_Constants.imageRadius),
        child: Container(
          color: Colors.black,
          child: Opacity(
            opacity: _Constants.newsImageLayerOpacity,
            child: Image.network(
              news.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  Widget _buildNewsInfo(BuildContext context) => Padding(
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

  Widget _buildNewsAuthor(BuildContext context) => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_Constants.imageRadius),
            child: Image.network(
              news.authorImageUrl,
              width: _Constants.authorImageSize,
              height: _Constants.authorImageSize,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: _Constants.authorDataSpacing,
          ),
          Text(
            news.authorName,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      );

  Widget _buildNewsTitle(BuildContext context) {
    var wrappingThreshold = MediaQuery.of(context).size.width * _Constants.wrappingThresholdPercent;

    return Container(
      width: wrappingThreshold,
      child: Column(
        children: [
          Text(
            news.title,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.white,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkIcon() => Padding(
        padding: const EdgeInsets.all(_Constants.stackItemPadding),
        child: Icon(
          Icons.bookmark,
          color: Colors.white,
        ),
      );
}
