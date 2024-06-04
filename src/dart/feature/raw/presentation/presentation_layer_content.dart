import '../../../common.dart';
import '../../../extensions/string_extension.dart';

/// PresentationLayerContent
/// This class is used to store the presentation layer content
/// 
class PresentationLayerContent {
  // @desc: create screen content
  // @param: featureName, name
  // @return: String
  static String createScreenContent(String featureName) {
    return '''
    import 'package:flutter/material.dart';
    import '../widgets/widgets.dart';

    class ${featureName.capitalize()}Screen extends StatelessWidget {
      const ${featureName.capitalize()}Screen({super.key});
      
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('${featureName.capitalize()}'),
          ),
          body: ${featureName.capitalize()}Widgets.displayMainContent(text: '${featureName.capitalize()} Screen'),
        );
      }
    }
  ''';
  }

  // @desc: create screen export content
  // @param: featureName, name
  // @return: String
  static String createScreenExportContent(String featureName) {
    return '''
    export '${featureName.toSnakeCase()}_screen.dart';
  ''';
  }

  // @desc: create widget content
  // @param: featureName, name
  // @return: String
  static String createWidgetContent(String featureName) {
    return '''
      import 'package:flutter/material.dart';
      class ${featureName.capitalize()}Widgets {
        static displayMainContent({String? text}) {
          return Center(
            child: Text(text ?? "${featureName.capitalize()} widget"),
          );
        }
      }
    ''';
  }

  // @desc: create widget export content
  // @param: featureName, name
  // @return: String
  static String createWidgetExportContent(String featureName) {
    return '''
      export '${featureName.toSnakeCase()}_widget.dart';
    ''';
  }

  // @desc: create bloc content
  // @param: featureName, name
  // @return: String
  static String createBlocStateContent(String featureName) {
    return '''
      part of "${featureName.toSnakeCase()}_bloc.dart";
      abstract class ${featureName.capitalize()}State extends Equatable {
        const ${featureName.capitalize()}State();
      
        @override
        List<Object> get props => [];
      }

      class ${featureName.capitalize()}Initial extends ${featureName.capitalize()}State {}
      class ${featureName.capitalize()}Loading extends ${featureName.capitalize()}State {}
      class ${featureName.capitalize()}Loaded extends ${featureName.capitalize()}State {
        final ${featureName.capitalize()}Entity entity;
        const ${featureName.capitalize()}Loaded(this.entity);
      }
      class ${featureName.capitalize()}Error extends ${featureName.capitalize()}State {
        final String message;
        const ${featureName.capitalize()}Error(this.message);
      }
    ''';
  }

  // @desc: create bloc export content
  // @param: featureName, name
  // @return: String   
  static String createBlocEventContent(String featureName) {
    return '''
      part of "${featureName.toSnakeCase()}_bloc.dart";
      abstract class ${featureName.capitalize()}Event extends Equatable {
        const ${featureName.capitalize()}Event();
      
        @override
        List<Object> get props => [];
      }

      class ${featureName.capitalize()}Fetch extends ${featureName.capitalize()}Event {}
    ''';
  }

  // @desc: create bloc export content
  // @param: featureName, name
  // @return: String
  static String createBlocContent(String featureName) {
    return '''
      import 'dart:async';
      import 'package:flutter_bloc/flutter_bloc.dart';
      import 'package:equatable/equatable.dart';
      import 'package:$package/src/core/network/data_state.dart';
      import '../../../domain/entities/${featureName.toSnakeCase()}_entity.dart';
      import '../../../domain/usecases/${featureName.toSnakeCase()}_usecase.dart';

      part "${featureName.toSnakeCase()}_state.dart";
      part "${featureName.toSnakeCase()}_event.dart";

      class ${featureName.capitalize()}Bloc extends Bloc<${featureName.capitalize()}Event, ${featureName.capitalize()}State> {
        final ${featureName.capitalize()}UseCase _useCase;
        ${featureName.capitalize()}Bloc(this._useCase) : super(${featureName.capitalize()}Initial()){
          on<${featureName.capitalize()}Event>(on${featureName.capitalize()}Event);
        }

        FutureOr<void> on${featureName.capitalize()}Event(${featureName.capitalize()}Event event, Emitter<${featureName.capitalize()}State> emit) async {
          final dataState = await _useCase.get();
          if (dataState is DataSucessState<${featureName.capitalize()}Entity>) {
            emit(${featureName.capitalize()}Loaded(dataState.data!));
          } else if (dataState is DataErrorState) {
            emit(${featureName.capitalize()}Error(dataState.error ?? "something went wrong"));
          }
        }
      }
    ''';
  }
}
