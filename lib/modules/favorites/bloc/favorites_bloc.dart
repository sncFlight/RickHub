import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:rick_hub/modules/favorites/models/favorite_character.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  late Box<FavoriteCharacter> _favoritesBox;

  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddToFavoritesEvent>(_onAddToFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
    on<SortFavoritesEvent>(_onSortFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      _favoritesBox = await Hive.openBox<FavoriteCharacter>('favorites');
      final favorites = _favoritesBox.values.toList();
      emit(FavoritesLoaded(favorites: favorites, sortType: SortType.name));
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> _onAddToFavorites(
    AddToFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesBox.put(event.character.id, event.character);
      final favorites = _favoritesBox.values.toList();
      
      if (state is FavoritesLoaded) {
        emit(FavoritesLoaded(
          favorites: favorites,
          sortType: (state as FavoritesLoaded).sortType,
        ));
      } else {
        emit(FavoritesLoaded(favorites: favorites, sortType: SortType.name));
      }
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesBox.delete(event.characterId);
      final favorites = _favoritesBox.values.toList();
      
      if (state is FavoritesLoaded) {
        emit(FavoritesLoaded(
          favorites: favorites,
          sortType: (state as FavoritesLoaded).sortType,
        ));
      } else {
        emit(FavoritesLoaded(favorites: favorites, sortType: SortType.name));
      }
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> _onSortFavorites(
    SortFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      List<FavoriteCharacter> sortedFavorites = List.from(currentState.favorites);

      switch (event.sortType) {
        case SortType.name:
          sortedFavorites.sort((a, b) => a.name.compareTo(b.name));
          break;
        case SortType.status:
          sortedFavorites.sort((a, b) => a.status.compareTo(b.status));
          break;
      }

      emit(FavoritesLoaded(
        favorites: sortedFavorites,
        sortType: event.sortType,
      ));
    }
  }

  bool isFavorite(int characterId) {
    return _favoritesBox.containsKey(characterId);
  }
}
