import 'package:rick_hub/modules/home/filter.dart';

class CharactersState {
  final List<dynamic> loadedCharacters;
  final CharactersStatus formStatus;
  final Filter filter;

  CharactersState({
    this.loadedCharacters = const [],
    this.formStatus = CharactersStatus.empty,
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
      filter: filter ?? this.filter
    );
  }
}

enum CharactersStatus {
  empty,
  loading,
  loaded,
  error,
}
