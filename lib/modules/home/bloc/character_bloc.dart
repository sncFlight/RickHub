import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/modules/home/bloc/character_event.dart';
import 'package:rick_hub/modules/home/bloc/character_state.dart';
import 'package:rick_hub/modules/home/models/character.dart';
import 'package:rick_hub/modules/home/services/character_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState>{
  final CharactersRepository? charactersRepository;

  CharactersBloc({
    this.charactersRepository,
  }) : super(CharactersState()) {
    on<CharactersPulledToRefreshEvent>(_onPulledToRefreshEventCallback);
  }

  Future<void> _onPulledToRefreshEventCallback(CharactersPulledToRefreshEvent event, Emitter emit) async {
    emit(state.copyWith(formStatus: CharactersStatus.loading));

    try {
      final List<Character> LoadedCharactersList = await charactersRepository!.getAllCharacters();

      emit(state.copyWith(
        loadedCharacters: LoadedCharactersList,
        formStatus: CharactersStatus.loaded,
      ));
    } catch (_) {
      emit(state.copyWith(formStatus: CharactersStatus.error));
    }
  }
}