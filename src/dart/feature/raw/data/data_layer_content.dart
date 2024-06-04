import '../../../common.dart';
import '../../../extensions/string_extension.dart';

/// DataLayerContent
/// This class is used to store the data layer content
///
class DataLayerContent {
  // @desc: create data model content
  // @param: featureName, name
  // @return: String
  static String createDataModelContent(String featureName) {
    return '''
      import '../../domain/entities/${featureName.toSnakeCase()}_entity.dart';
      class ${featureName.capitalize()}Model extends ${featureName.capitalize()}Entity {
        ${featureName.capitalize()}Model ({super.id, super.field});

        ${featureName.capitalize()}Model.fromJson(Map<String, dynamic> json) {
          ${featureName.capitalize()}Model(
            id: json['id'],
            field: json['field'],
          );
        }

        toEntity() {
          return ${featureName.capitalize()}Entity(
            id: id,
            field: field,
          );
        }
      }
    ''';
  }

  // @desc: create remote data source content
  // @param: featureName, name
  // @return: String 
  static String createRemoteDataSourceContent(String featureName) {
    return '''
      import 'package:http/http.dart' as http;
      abstract class ${featureName.capitalize()}RemoteDataSource {
        Future<http.Response> get();
      }

      class ${featureName.capitalize()}RemoteDataSourceImpl extends ${featureName.capitalize()}RemoteDataSource {
        @override
        Future<http.Response> get() async {
          // TODO: replace url
          final response = http.get(Uri.parse("URL"));
          return response;
        }
      }
    ''';
  }

  // @desc: create local data source content
  // @param: featureName, name
  // @return: String
  static String createLocalDataSourceContent(String featureName) {
    return "";
  }

  // @desc: create data repository content
  // @param: featureName, name
  // @return: String
  static String createDataRepositoryContent(String featureName) {
    return '''
      import 'dart:convert';
      import 'package:$package/src/core/network/data_state.dart';
      import '../../domain/repositories/${featureName.toSnakeCase()}_repository.dart';
      import '../datasources/remote//${featureName.toSnakeCase()}_remote_data_source.dart';
      import '../models/${featureName.toSnakeCase()}_model.dart';

      class ${featureName.capitalize()}RepositoryImpl implements ${featureName.capitalize()}Repository {
        final ${featureName.capitalize()}RemoteDataSource _${featureName.toLowerCase()}remoteDataSource;
        ${featureName.capitalize()}RepositoryImpl(this._${featureName.toLowerCase()}remoteDataSource);

        @override
        Future<DataState<${featureName.capitalize()}Model>> get() async {
          try {
            final response = await _${featureName.toLowerCase()}remoteDataSource.get();
            final json = jsonDecode(response.body);
            final dataModel = ${featureName.capitalize()}Model.fromJson(json);
            return DataSucessState(dataModel);
          } catch (e) {
            return DataErrorState(e.toString());
          }
        }
      }
    ''';
  }
}
