class Character {
  final int id;
  final String name;
  final String status;
  final String gender;
  final String originName;
  final String locationName;
  final String imageUrl;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.imageUrl,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        gender: json["gender"],
        originName: json["origin"]["name"],
        locationName: json["location"]["name"],
        imageUrl: json["image"],
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "status": status,
//     "gender": gender,
//     "origin": origin,
//     "location": location,
//     "image": image,
//     "url": url,
//     "created": created.toIso8601String(),
//   };
// }

// class CharacterLocation {
//   CharacterLocation({
//     required this.name,
//     required this.url,
//   });
//
//   String name;
//   String url;
//
//   factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
//     CharacterLocation(
//       name: json["name"],
//       url: json["url"],
//     );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "url": url,
//   };
// }
