import 'package:allthenews/ui/common/util/dimens.dart';
import 'package:allthenews/ui/common/util/strings.dart';
import 'package:allthenews/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_view.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 16.0;
}

class SecondaryNewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: _Constants.sectionHeaderPadding),
            SecondaryNewsListView(
                secondaryNewsListEntities: secondaryNewsListEntities),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: Dimens.pagePadding,
          left: Dimens.pagePadding,
          right: Dimens.pagePadding,
        ),
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
            PrimaryIconButton(
              iconData: Icons.search,
              onPressed: () {},
            ),
          ],
        ),
      );
}
