import 'package:allthenews/ui/pages/news_list/news_list_item.dart';
import 'package:allthenews/ui/pages/news_list/news_view_entity.dart';
import 'package:flutter/material.dart';

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
          padding: EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Middle East",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 10,
              ),
              NewsListItem(
                news: NewsViewEntity(
                    title:
                        "Egypt Is on Edge as Security Tightens Over Protests",
                    date: "Sept. 26, 2019",
                    time: "1:41 PM",
                    imageUrl: "https://i.picsum.photos/id/9/250/250.jpg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
