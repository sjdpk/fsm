import '../../../extensions/string_extension.dart';
import '../../services/file_service.dart';
import 'domain_layer_content.dart';

/// DomainLayer
/// @desc: create domain layer folder structure
class DomainLayer {
  // @desc: create domain layer folder structure
  // @param: featureName, name
  // @return: void
  static void createDomainLayerFolderStr(String featureName) {
    // - Entities/$featureName_entity.dart
    FileService.createFolder(
      dir: "$featureName/domain/entities",
      isFeature: true,
    ).then((path) {
      FileService.addContentAndFile(
        path: path,
        fileName: "/${featureName.toSnakeCase()}_entity.dart",
        content: DomainLayerContent.createDomainEntityContent(featureName),
      );
    });

    // - Repositories/$featureName_repository.dart
    FileService.createFolder(
      dir: "$featureName/domain/repositories",
      isFeature: true,
    ).then((path) {
      FileService.addContentAndFile(
        path: path,
        fileName: "/${featureName.toSnakeCase()}_repository.dart",
        content: DomainLayerContent.createDomainRepositoryContent(featureName),
      );
    });

    // - Use Cases/$featureName_usecase.dart
    FileService.createFolder(
      dir: "$featureName/domain/usecases",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_usecase.dart",
        content: DomainLayerContent.createDomainUseCaseContent(featureName),
      );
    });
  }
}
