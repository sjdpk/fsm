/// DataStateContent
/// @desc : create data state content
class DataStateContent {
  
  // desc: create data state content
  // return: String
  static String createDataStateContent() {
    return '''
      abstract class DataState<T> {
        final T? data;
        final String? error;
        const DataState({this.data, this.error});
      }

      class DataSucessState<T> extends DataState<T> {
        const DataSucessState(T data) : super(data: data);
      }

      class DataErrorState<T> extends DataState<T> {
        const DataErrorState(String? error) : super(error: error);
      }
    ''';
  }
}
