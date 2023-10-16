// abstract class CharactersState {}
//
// class CharactersEmptyState extends CharactersState {}
//
// class CharactersLoadingState extends CharactersState {}

class CharactersState {
  final List<dynamic> loadedCharacters;
  final CharactersStatus formStatus;

  CharactersState({
    this.loadedCharacters = const [],
    this.formStatus = CharactersStatus.empty,
  });

  CharactersState copyWith({
    List<dynamic>? loadedCharacters,
    CharactersStatus? formStatus,
  }) {
    return CharactersState(
      loadedCharacters: loadedCharacters ?? this.loadedCharacters,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

enum CharactersStatus {
  empty,
  loading,
  loaded,
  error,
}
