import 'package:rick_hub/modules/home/models/character.dart';
import 'package:rick_hub/modules/home/services/character_provider.dart';

class CharactersRepository {
  CharactersProvider _charactersProvider = CharactersProvider();

  Future<List<Character>> getAllCharacters() => _charactersProvider.getAllCharacters();
}