import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/presentation/presentation_step.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PresentationStepsProvider {
  List<PresentationStep> _presentationSteps = [];

  List<PresentationStep> provide() {
    if (_presentationSteps.isEmpty) {
      _presentationSteps = [
        PresentationStep(
          title: UntranslatableStrings.appName,
          description: Strings.current.appInfoTechnicalDescription,
          presentationImageType: PresentationImageType.flutterLogo,
        ),
        PresentationStep(
          title: UntranslatableStrings.appName,
          description: Strings.current.appInfoFeatureDescription,
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
