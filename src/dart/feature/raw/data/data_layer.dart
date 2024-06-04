import '../../../extensions/string_extension.dart';
import '../../services/file_service.dart';
import 'data_layer_content.dart';

/// Data Layer
/// @desc: create feature directories
class DataLayer {
  // @desc: create data model content
  // @param: featureName, name
  // @return: void
  static void createDataLayerFolderStr(String featureName) {
    // - Models/$featureName_model.dart
    FileService.createFolder(
      dir: "$featureName/data/models",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_model.dart",
        content: DataLayerContent.createDataModelContent(featureName),
      );
    });

    // - Data Sources/Local/Local Data Source
    FileService.createFolder(
      dir: "$featureName/data/data_sources/local",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_local_data_source.dart",
        content: DataLayerContent.createLocalDataSourceContent(featureName),
      );
    });

    // - Remote/Remote Data Source
    FileService.createFolder(
      dir: "$featureName/data/data_sources/remote",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_remote_data_source.dart",
        content: DataLayerContent.createRemoteDataSourceContent(featureName),
      );
    });

    FileService.createFolder(
      dir: "$featureName/data/repositories",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_repository.dart",
        content: DataLayerContent.createDataRepositoryContent(featureName),
      );
    });
  }
}
