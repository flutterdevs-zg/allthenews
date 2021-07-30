import 'package:flutter/material.dart';

abstract class _Constants {
  static const iconSpacing = 15.0;
}

class UserSectionItem extends StatelessWidget {
  const UserSectionItem({
    required Function(BuildContext) action,
    required String label,
    required IconData icon,
  })  : _action = action,
        _label = label,
        _icon = icon;

  final Function(BuildContext) _action;
  final String _label;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Row(children: [
        Icon(_icon, color: Theme.of(context).indicatorColor),
        const SizedBox(width: _Constants.iconSpacing),
      ]),
      label: Text(
        _label,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onPressed: () => _action(context),
    );
  }
}
