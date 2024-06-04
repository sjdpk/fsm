import '../../../extensions/string_extension.dart';
import '../../services/file_service.dart';
import 'presentation_layer_content.dart';

/// PresentationLayer
/// @desc: create presentation layer folder structure
class PresentationLayer {
  // @desc: create presentation layer folder structure
  // @param: featureName, name
  // @return: void
  static void createPresentationLayerFolderStr(String featureName) {
    // presentation layer
    final blocFolder = "$featureName/presentation/bloc/$featureName";
    FileService.createFolder(
      dir: blocFolder,
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_state.dart",
        content: PresentationLayerContent.createBlocStateContent(featureName),
      );
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_event.dart",
        content: PresentationLayerContent.createBlocEventContent(featureName),
      );

      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_bloc.dart",
        content: PresentationLayerContent.createBlocContent(featureName),
      );
    });

    FileService.createFolder(
      dir: "$featureName/presentation/widgets",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_widget.dart",
        content: PresentationLayerContent.createWidgetContent(featureName),
      );
      FileService.addContentAndFile(
        path: value,
        fileName: "/widgets.dart",
        content:
            PresentationLayerContent.createWidgetExportContent(featureName),
      );
    });
    FileService.createFolder(
      dir: "$featureName/presentation/screens",
      isFeature: true,
    ).then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/${featureName.toSnakeCase()}_screen.dart",
        content: PresentationLayerContent.createScreenContent(featureName),
      );
      FileService.addContentAndFile(
        path: value,
        fileName: "/screens.dart",
        content:
            PresentationLayerContent.createScreenExportContent(featureName),
      );
    });
  }
}
