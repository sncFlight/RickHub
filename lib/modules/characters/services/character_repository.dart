import 'package:rick_hub/modules/characters/filters/filter.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/characters/services/character_provider.dart';

class CharactersRepository {
  CharactersProvider _charactersProvider = CharactersProvider();

  Future<List<Character>> getAllCharacters(Filter filter) => _charactersProvider.getAll(filter);
}