import 'package:allthenews/src/ui/pages/profile/user_section_item.dart';
import 'package:flutter/material.dart';

class UserSectionWidget extends StatelessWidget {
  final String _title;
  final List<UserSectionItem> _children;

  const UserSectionWidget({
    required String title,
    required List<UserSectionItem> children,
  })  : _title = title,
        _children = children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_title, style: Theme.of(context).textTheme.headline6),
        Column(
          children: _children,
        )
      ],
    );
  }
}
