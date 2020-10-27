import 'package:allthenews/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(Strings.of(context).profile),
    );
  }
}
