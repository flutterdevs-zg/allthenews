import 'package:allthenews/ui/common/widget/dot_separator.dart';
import 'package:allthenews/ui/pages/news_list/news_view_entity.dart';
import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final NewsViewEntity news;

  NewsListItem({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildImage(),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              SizedBox(height: 8),
              _buildSubtitle(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) => Text(
        news.title,
        style: Theme.of(context).textTheme.subtitle2,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildImage() => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          'https://i.picsum.photos/id/9/800/800.jpg',
          width: 110,
          height: 90,
          fit: BoxFit.fill,
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
          width: 20,
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
