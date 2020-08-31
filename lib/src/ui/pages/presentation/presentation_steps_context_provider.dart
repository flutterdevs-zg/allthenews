import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/presentation/presentation_step.dart';
import 'package:allthenews/src/domain/presentation/presentation_steps_provider.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PresentationStepsContextProvider implements PresentationStepsProvider<BuildContext> {
  List<PresentationStep> _presentationSteps = [];

  @override
  List<PresentationStep> provide(BuildContext buildContext) {
    if (_presentationSteps.isEmpty) {
      _presentationSteps = [
        PresentationStep(
          title: UntranslatableStrings.appName,
          description: Strings.of(buildContext).appInfoTechnicalDescription,
          presentationImageType: PresentationImageType.flutterLogo,
        ),
        PresentationStep(
          title: UntranslatableStrings.appName,
          description: Strings.of(buildContext).appInfoFeatureDescription,
          presentationImageType: PresentationImageType.newsIcon,
        ),
      ];
    }
    return _presentationSteps;
  }
}

extension PresentationImageTypeExtenstions on PresentationImageType {
  Widget getImage() {
    switch (this) {
      case PresentationImageType.flutterLogo:
        return const FlutterLogo();
      case PresentationImageType.newsIcon:
        return SvgPicture.asset('assets/images/news.svg', color: Colors.grey);
    }
    return null;
  }
}
