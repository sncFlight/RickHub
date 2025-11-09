import 'package:rick_hub/modules/characters/filters/filter.dart';

class CharactersState {
  final List<dynamic> loadedCharacters;
  final CharactersStatus formStatus;
  final Filter filter;

  CharactersState({
    this.loadedCharacters = const [],
    this.formStatus = CharactersStatus.initial,
    this.filter = const Filter(),
  });

  CharactersState copyWith({
    List<dynamic>? loadedCharacters,
    CharactersStatus? formStatus,
    Filter? filter,
  }) {
    return CharactersState(
        loadedCharacters: loadedCharacters ?? this.loadedCharacters,
        formStatus: formStatus ?? this.formStatus,
        filter: filter ?? this.filter);
  }
}

enum CharactersStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
}
