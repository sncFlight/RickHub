abstract class CharactersEvent {}

class CharactersPulledToRefreshEvent extends CharactersEvent {}

class CharactersSearchChangedEvent extends CharactersEvent {
  final String searchString;

  CharactersSearchChangedEvent({required this.searchString});
}

