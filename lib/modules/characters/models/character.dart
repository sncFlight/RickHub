class Character {
  final int id;
  final String name;
  final String status;
  final String gender;
  final String originName;
  final String locationName;
  final String imageUrl;
  final String url;
  final String species;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.imageUrl,
    required this.url,
    required this.species,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      gender: json["gender"],
      originName: json["origin"]["name"],
      locationName: json["location"]["name"],
      imageUrl: json["image"],
      url: json["url"],
      species: json["species"],
    );
  }
}