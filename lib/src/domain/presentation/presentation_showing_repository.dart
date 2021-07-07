abstract class PresentationShowingRepository {

  Future<bool?> shouldShowPresentation();

  Future<void> savePresentationShowed();
}