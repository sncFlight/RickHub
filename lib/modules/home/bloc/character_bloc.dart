import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/modules/home/bloc/character_event.dart';
import 'package:rick_hub/modules/home/bloc/character_state.dart';
import 'package:rick_hub/modules/home/filter.dart';
import 'package:rick_hub/modules/home/models/character.dart';
import 'package:rick_hub/modules/home/services/character_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState>{
  final CharactersRepository? charactersRepository;

  CharactersBloc({
    this.charactersRepository,
  }) : super(CharactersState()) {
    on<CharactersSearchChangedEvent>(_onCharactersSearchChangedEvent);
    on<CharactersPulledToRefreshEvent>(_onPulledToRefreshEventCallback);
    on<CharactersLoadedMoreEvent>(_onCharactersLoadedMoreEvent);
  }

  Future<void> _onCharactersSearchChangedEvent(CharactersSearchChangedEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: CharactersStatus.loading,
        filter: Filter(
          name: event.searchString,
        ),
      )
    );

    await refreshData(
      event: event,
      emit: emit
    );
  }

  Future<void> _onCharactersLoadedMoreEvent(CharactersLoadedMoreEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: CharactersStatus.loading,
        filter: Filter(
          page: state.filter.page + 1,
          name: state.filter.name,
        ),
      )
    );

    await refreshData(
      event: event,
      emit: emit
    );
  }

  Future<void> _onPulledToRefreshEventCallback(CharactersPulledToRefreshEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: CharactersStatus.loading,
        filter: Filter(name: state.filter.name),
      )
    );

    await refreshData(
      event: event,
      emit: emit
    );
  }

  Future<void> refreshData({
    required CharactersEvent event,
    required Emitter emit
  }) async {
    try {
      final List<Character> LoadedCharactersList = await charactersRepository!.getAllCharacters(state.filter);

      emit(
        state.copyWith(
          loadedCharacters: LoadedCharactersList,
          formStatus: CharactersStatus.loaded,
          filter: Filter(
            page: state.filter.page,
            name: state.filter.name,
          )
        )
      );
    } catch (_) {
      emit(state.copyWith(formStatus: CharactersStatus.error));
    }
  }
}