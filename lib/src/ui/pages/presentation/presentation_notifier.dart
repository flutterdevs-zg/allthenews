import 'package:allthenews/src/domain/presentation/presentation_showing_repository.dart';
import 'package:flutter/material.dart';

class PresentationNotifier extends ChangeNotifier {

  final PresentationShowingRepository _presentationShowingRepository;

  PresentationNotifier(this._presentationShowingRepository);

  bool _shouldShowPresentation = false;
  bool _isLoading = false;

  bool get shouldShowPresentation => _shouldShowPresentation;
  bool get isLoading => _isLoading;

  Future<void> checkAppPresentation() async {
    _isLoading = true;
    _shouldShowPresentation = await _presentationShowingRepository.shouldShowPresentation() ?? true;
    _isLoading = false;
    notifyListeners();
  }

  void completePresentation() {
    _presentationShowingRepository.savePresentationShowed();
  }
}
