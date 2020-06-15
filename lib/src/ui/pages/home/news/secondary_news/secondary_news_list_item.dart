import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/widget/dot_separator.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/web_view/web_view_page.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const imageBorderRadius = 8.0;
  static const imageHeight = 90.0;
  static const imageHorizontalSpacing = 20.0;
  static const imageWidth = 110.0;
  static const subtitleHorizontalPadding = 20.0;
  static const titleMaxLines = 2;
  static const titleVerticalSpacing = 8.0;
  static const verticalListItemPadding = 13.0;
}

class SecondaryNewsListItem extends StatelessWidget {
  final SecondaryNewsListEntity news;

  SecondaryNewsListItem({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(url: news.articleUrl),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.pagePadding,
            vertical: _Constants.verticalListItemPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              SizedBox(width: _Constants.imageHorizontalSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context),
                    SizedBox(height: _Constants.titleVerticalSpacing),
                    _buildSubtitle(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) => Text(
        news.title,
        style: Theme.of(context).textTheme.subtitle2,
        maxLines: _Constants.titleMaxLines,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildImage() => ClipRRect(
        borderRadius: BorderRadius.circular(_Constants.imageBorderRadius),
        child: Image.network(
          news.imageUrl,
          width: _Constants.imageWidth,
          height: _Constants.imageHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget _buildSubtitle(BuildContext context) {
    final subtitleStyle = Theme.of(context).textTheme.overline;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.date,
          style: subtitleStyle,
        ),
        Container(
          alignment: Alignment.center,
          width: _Constants.subtitleHorizontalPadding,
          child: DotSeparator(
            size: subtitleStyle.fontSize,
            color: subtitleStyle.color,
          ),
        ),
        Text(
          news.time,
          style: subtitleStyle,
        ),
      ],
    );
  }
}
