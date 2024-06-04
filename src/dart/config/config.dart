import '../feature/services/file_service.dart';
import 'raw/datastate_content.dart';

/// ConfigSetup
/// @desc : setup config
class ConfigSetup {
  // @desc: create data state setup
  // @return: void
  static void networkStateConfigSetup() {
    FileService.createFolder(dir: "lib/src/core/network").then((value) {
      FileService.addContentAndFile(
        path: value,
        fileName: "/data_state.dart",
        content: DataStateContent.createDataStateContent(),
      );
    });
  }
}
