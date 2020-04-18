import 'package:allthenews/ui/common/style/text_style_provider.dart';
import 'package:allthenews/ui/common/widget/dot.dart';
import 'package:allthenews/ui/pages/news_list/news_view_entity.dart';
import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final NewsViewEntity news;

  NewsListItem({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleProvider = TextStyleProvider(buildContext: context);
    return Row(
      children: [
        _buildImage(),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(textStyleProvider),
              SizedBox(height: 8),
              _buildSubtitle(textStyleProvider),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitle(TextStyleProvider textStyleProvider) => Text(
        news.title,
        style: textStyleProvider.provideTitleTextStyle(),
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

  Widget _buildSubtitle(TextStyleProvider textStyleProvider) {
    final style = textStyleProvider.provideSubtitleTextStyle();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(news.date, style: style),
        Container(
            alignment: Alignment.center,
            width: 20,
            child: Dot(
              textStyle: style,
            )),
        Text(news.time, style: style),
      ],
    );
  }
}

