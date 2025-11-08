import 'package:hive/hive.dart';

part 'favorite_character.g.dart';

@HiveType(typeId: 0)
class FavoriteCharacter extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final String species;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String originName;

  @HiveField(7)
  final String locationName;

  FavoriteCharacter({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.species,
    required this.gender,
    required this.originName,
    required this.locationName,
  });
}
