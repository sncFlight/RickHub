import 'package:rick_hub/modules/favorites/bloc/favorites_state.dart';
import 'package:rick_hub/modules/favorites/models/favorite_character.dart';

abstract class FavoritesEvent {}

class LoadFavoritesEvent extends FavoritesEvent {}

class AddToFavoritesEvent extends FavoritesEvent {
  final FavoriteCharacter character;

  AddToFavoritesEvent({required this.character});
}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final int characterId;

  RemoveFromFavoritesEvent({required this.characterId});
}

class SortFavoritesEvent extends FavoritesEvent {
  final SortType sortType;

  SortFavoritesEvent({required this.sortType});
}
