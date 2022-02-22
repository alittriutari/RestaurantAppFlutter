class Favorite {
  late String? id;
  late String name;
  late String pictureId;
  late String city;
  late double rating;
  late int isFavorite;

  Favorite({this.id, required this.name, required this.pictureId, required this.city, required this.rating, this.isFavorite = 0});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'pictureId': pictureId, 'city': city, 'rating': rating, 'isFavorite': isFavorite};
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name:
    map["name"];
    pictureId:
    map["pictureId"];
    city:
    map["city"];
    rating:
    map["rating"].toDouble();
    isFavorite:
    map["isFavorite"];
  }
}
