import 'package:allthenews/src/domain/presentation/presentation_showing_repository.dart';
import 'package:flutter/material.dart';

class PresentationNotifier extends ChangeNotifier {

  final PresentationShowingRepository _presentationShowingRepository;

  PresentationNotifier(this._presentationShowingRepository);

  bool _shouldShowPresentation;

  bool get shouldShowPresentation => _shouldShowPresentation;
  bool get isLoading => _shouldShowPresentation == null;

  Future<void> checkAppPresentation() async {
    _shouldShowPresentation = await _presentationShowingRepository.shouldShowPresentation();
    notifyListeners();
  }

  void completePresentation() {
    _presentationShowingRepository.savePresentationShowed();
  }
}
