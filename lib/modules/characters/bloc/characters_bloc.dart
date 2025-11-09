import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_hub/modules/characters/bloc/character_event.dart';
import 'package:rick_hub/modules/characters/bloc/characters_state.dart';
import 'package:rick_hub/modules/characters/filters/filter.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/characters/services/character_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository? charactersRepository;
  bool canSearch = true;

  CharactersBloc({
    this.charactersRepository,
  }) : super(CharactersState()) {
    on<CharactersPulledToRefreshEvent>(_onPulledToRefreshEventCallback);
    on<CharactersLoadedMoreEvent>(_onCharactersLoadedMoreEvent);
  }

  Future<void> _onCharactersLoadedMoreEvent(
      CharactersLoadedMoreEvent event, Emitter emit) async {
    final newFilter = Filter(
      page: state.filter.page + 1,
      name: state.filter.name,
    );

    try {
      final List<Character> loadedCharactersList =
          await charactersRepository!.getAllCharacters(newFilter);

      if (loadedCharactersList.isNotEmpty) {
        emit(state.copyWith(
          loadedCharacters: state.loadedCharacters + loadedCharactersList,
          formStatus: CharactersStatus.loaded,
          filter: newFilter,
        ));
      }
    } catch (_) {
      emit(state.copyWith(formStatus: CharactersStatus.error));
    }
  }

  Future<void> _onPulledToRefreshEventCallback(
      CharactersPulledToRefreshEvent event, Emitter emit) async {
    if (state.loadedCharacters.isNotEmpty) {
      state.loadedCharacters.clear();
    }

    emit(state.copyWith(
      formStatus: CharactersStatus.loading,
      filter: Filter(name: state.filter.name),
    ));

    await refreshData(event: event, emit: emit);
  }

  Future<void> refreshData(
      {required CharactersEvent event, required Emitter emit}) async {
    try {
      final List<Character> loadedCharactersList =
          await charactersRepository!.getAllCharacters(state.filter);

      final CharactersStatus status = loadedCharactersList.isEmpty
          ? CharactersStatus.empty
          : CharactersStatus.loaded;

      emit(state.copyWith(
          loadedCharacters: state.loadedCharacters + loadedCharactersList,
          formStatus: status,
          filter: Filter(
            page: state.filter.page,
            name: state.filter.name,
          )));
    } catch (_) {
      emit(state.copyWith(formStatus: CharactersStatus.error));
    }
  }
}
