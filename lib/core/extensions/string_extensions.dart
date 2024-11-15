extension StringExtensions on String {
  // Capitalizes the first letter of each word of the word
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
