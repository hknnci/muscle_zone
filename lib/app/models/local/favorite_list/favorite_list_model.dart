import 'package:hive/hive.dart';

part 'favorite_list_model.g.dart';

@HiveType(typeId: 0)
class FavoriteList extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> exerciseIds;

  FavoriteList({
    required this.name,
    required this.exerciseIds,
  });
}
