import 'package:allthenews/src/domain/common/persistence/persistence_repository.dart';
import 'package:allthenews/src/domain/presentation/presentation_showing_repository.dart';

class _Constants {
  static const shouldShowPresentationKey = 'shouldShowPresentationKey';
}

class PresentationShowingLocalRepository extends PresentationShowingRepository {
  final PersistenceRepository _persistenceRepository;

  PresentationShowingLocalRepository(this._persistenceRepository);

  @override
  Future<bool?> shouldShowPresentation() => _persistenceRepository.getBool(_Constants.shouldShowPresentationKey);

  @override
  Future<void> savePresentationShowed() => _persistenceRepository.saveBool(_Constants.shouldShowPresentationKey, false);
}
