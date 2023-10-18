import 'package:rick_hub/modules/characters/filters/filter.dart';
import 'package:dio/dio.dart';
import 'package:rick_hub/modules/characters/models/character.dart';


class CharactersProvider {
  static final Dio _dio = Dio();

  Future<List<Character>> getAll(Filter filter) async {
    try {
      final String url = 'https://rickandmortyapi.com/api/character?name=${filter.name}&page=${filter.page}';
      final Response response = await _dio.get(url);

      List<Map<String, dynamic>> rawCharacters = [];
      rawCharacters.addAll(List<Map<String, dynamic>>.from(response.data["results"]));

      final List<Character> characters = List<Character>.from(rawCharacters.map((x) => Character.fromJson(x)));

      return characters;
    } catch (e) {
      throw e;
    }
  }
}
