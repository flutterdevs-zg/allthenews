import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const retryButtonWidth = 120.0;
  static const retryButtonHeight = 40.0;
}

class RetryActionContainer extends StatelessWidget {
  final VoidCallback onRetryPressed;

  const RetryActionContainer({@required this.onRetryPressed}) : assert(onRetryPressed != null);

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          height: _Constants.retryButtonHeight,
          width: _Constants.retryButtonWidth,
          child: PrimaryTextButton(
            onPressed: onRetryPressed,
            text: Strings.current.retry,
          ),
        ),
      );
}
