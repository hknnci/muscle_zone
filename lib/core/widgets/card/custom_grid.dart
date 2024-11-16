import 'package:flutter/material.dart';

/// A generic grid widget that can display any type of items
/// and handle their selection.
class CustomGridView<T> extends StatelessWidget {
  /// Constructs a [CustomGridView] widget.
  const CustomGridView({
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.padding = const EdgeInsets.all(8),
    this.childAspectRatio,
    super.key,
  });

  /// List of items to display in the grid.
  final List<T> items;

  /// Builder function to create widget for each item.
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Spacing between columns.
  final double crossAxisSpacing;

  /// Spacing between rows.
  final double mainAxisSpacing;

  /// Padding around the grid.
  final EdgeInsets padding;

  /// Aspect ratio of each grid item.
  final double? childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio ?? 1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(context, items[index]),
      ),
    );
  }
}
