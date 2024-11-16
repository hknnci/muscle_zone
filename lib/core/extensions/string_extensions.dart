/// Provides additional string manipulation methods
extension StringExtensions on String {
  /// Converts the string to title case by capitalizing
  /// the first letter of each word
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
