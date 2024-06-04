import '../../../common.dart';
import '../../../extensions/string_extension.dart';

/// DomainLayerContent
/// @desc : create domain layer content
/// 
class DomainLayerContent {

  // @desc: create entities content
  // @param: featureName, name
  // @return: String
  static String createDomainEntityContent(String featureName) {
    return '''
      class ${featureName.capitalize()}Entity {
        String? id;
        String? field;

        ${featureName.capitalize()}Entity({
          this.id,
          this.field,
        });

        // to json 
        Map<String, dynamic> toJson() {
          return {
            "id": id,
            "field": field,
          };
        }
      }
    ''';
  }

  // @desc: create repositories content
  // @param: featureName, name
  // @return: String
  static String createDomainRepositoryContent(String featureName) {
    return '''
      import '../entities/${featureName.toSnakeCase()}_entity.dart';
      import 'package:$package/src/core/network/data_state.dart';

      abstract class ${featureName.capitalize()}Repository {
        Future<DataState<${featureName.capitalize()}Entity>> get();
      }
    ''';
  }

  // @desc: create use case content
  // @param: featureName, name
  // @return: String
  static String createDomainUseCaseContent(String featureName) {
    return '''
      import '../entities/${featureName.toSnakeCase()}_entity.dart';
      import '../repositories/${featureName.toSnakeCase()}_repository.dart';
      import 'package:$package/src/core/network/data_state.dart';

      class ${featureName.capitalize()}UseCase {
        final ${featureName.capitalize()}Repository _repository;

        ${featureName.capitalize()}UseCase(this._repository);

        Future<DataState<${featureName.capitalize()}Entity>> get() {
          return _repository.get();
        }
      }
    ''';
  }
}
