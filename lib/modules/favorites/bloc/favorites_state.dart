import 'package:rick_hub/modules/favorites/models/favorite_character.dart';

enum SortType { name, status }

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteCharacter> favorites;
  final SortType sortType;

  FavoritesLoaded({required this.favorites, required this.sortType});
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError({required this.message});
}
