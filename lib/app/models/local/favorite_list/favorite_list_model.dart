import 'package:hive_flutter/hive_flutter.dart';

part 'favorite_list_model.g.dart';

/// Model class representing a favorite exercise list
@HiveType(typeId: 0)
class FavoriteList extends HiveObject {
  /// Constructor for FavoriteList
  FavoriteList({
    required this.name,
    required this.exerciseIds,
  });

  /// Name of the favorite list
  @HiveField(0)
  String name;

  /// List of exercise IDs stored in this favorite list
  @HiveField(1)
  List<String> exerciseIds;
}
