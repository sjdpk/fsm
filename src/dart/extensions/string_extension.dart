// @desc : string extension to convert string to snake case
// @return : String
extension StringExtension on String {
  // convert string to snake case
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return "_${match.group(0)!.toLowerCase()}";
    }).replaceFirst("_", "");
  }

  // capitalize the first letter of the string
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
