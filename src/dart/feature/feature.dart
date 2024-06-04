import 'dart:io';

import '../config/config.dart';
import 'raw/data/data_layer.dart';
import 'raw/domain/domain_layer.dart';
import 'raw/presentation/presentation_layer.dart';

void main(List<String> args) {
  try {
    if (args.isEmpty) {
      throw Exception("Please provide a feature name");
    }

    final featureName = args[0];
    if (featureName.isEmpty) {
      throw Exception("Feature name cannot be empty");
    }

    ConfigSetup.networkStateConfigSetup();
    DomainLayer.createDomainLayerFolderStr(featureName);
    DataLayer.createDataLayerFolderStr(featureName);
    PresentationLayer.createPresentationLayerFolderStr(featureName);
  } catch (e) {
    print("${e.toString()}");
    // Exit with a non-zero status to indicate an error
    exit(1);
  }
}
