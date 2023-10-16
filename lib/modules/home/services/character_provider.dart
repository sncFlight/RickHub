import 'package:rick_hub/modules/home/models/character.dart';
import 'package:dio/dio.dart';
import 'package:rick_hub/modules/home/models/info.dart';

class CharactersProvider extends GetEntitiesService {
  final String baseUrl = "https://rickandmortyapi.com/api/";
  final String characterEndpoint = "character";

  Future<List<Character>> getAllCharacters() async {
    List<Map<String, dynamic>> objects = await super.getAllEntities('${this.baseUrl}${this.characterEndpoint}');

    return List<Character>.from(objects.map((x) => Character.fromJson(x)));
  }
}

abstract class GetEntitiesService {
  static final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getAllEntities(String url) async {
    try {
      List<Map<String, dynamic>> allEntities = [];
      String? nextUrl = url;
      while (nextUrl != null) {
        var response = await _dio.get(nextUrl);
        try {
          var dataInfo = response.data["info"];
          // So, we have info object and pagination
          Info info = Info.fromJson(response.data["info"]);
          nextUrl = info.next;
          allEntities.addAll(
              List<Map<String, dynamic>>.from(response.data["results"]));
        } catch (e) {
          // We don't have info object and pagination
          allEntities.addAll(List<Map<String, dynamic>>.from(response.data));
          nextUrl = null;
        }
      }

      return allEntities;
    } on DioError {
      rethrow;
    }
  }
}
