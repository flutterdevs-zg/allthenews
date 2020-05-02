import 'package:allthenews/ui/common/widget/primary_button.dart';
import 'package:allthenews/ui/pages/news_list/news_list_view.dart';
import 'package:allthenews/ui/pages/news_list/news_view_entity.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const newestText = "Newest";
  static const showAllText = "Show All";
  static const pagePadding = 26.0;
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
        child: Padding(
          padding: EdgeInsets.all(_Constants.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNewsSectionHeader(),
              SizedBox(height: _Constants.sectionHeaderPadding),
              NewsListView(newsViewEntities: newsViewEntities),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsSectionHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _Constants.newestText,
            style: Theme.of(context).textTheme.headline3,
          ),
          PrimaryButton(
            text: _Constants.showAllText,
            onPressed: () {},
          ),
        ],
      );
}
