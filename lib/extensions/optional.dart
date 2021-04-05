
extension StringExtension on String? {
  String get orEmpty {
    return this == null ? '' : this!;
  }
}

extension ListExtension on List? {
  List get orEmpty {
    return this == null ? [] : this!;
  }
}