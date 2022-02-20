class Favorite {
  late int? id;
  late int favorite;
  late String restaurantId;

  Favorite({
    this.id,
    required this.favorite,
    required this.restaurantId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'favorite': favorite, 'restaurantId': restaurantId};
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    favorite = map['favorite'];
    restaurantId = map['restaurantId'];
  }
}
