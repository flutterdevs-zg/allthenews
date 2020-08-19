import 'package:allthenews/src/domain/presentation/presentation_step.dart';

abstract class PresentationStepsProvider<T> {
  List<PresentationStep> provide(T messageProvider);
}
