import 'package:meta/meta.dart';

class PresentationStep {
  final String title;
  final String description;
  final PresentationImageType presentationImageType;

  const PresentationStep({
    @required this.title,
    @required this.description,
    @required this.presentationImageType,
  });
}

enum PresentationImageType { flutterLogo, newsIcon }
