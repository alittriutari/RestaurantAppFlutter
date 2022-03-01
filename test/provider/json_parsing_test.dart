import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  test('parsing json restaurant into model', () {
    const id = 's1knt6za9kkfw1e867';
    const name = 'Kafe Kita';
    const description = 'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...';
    const pictureId = '25';
    const city = 'Gorontalo';
    const rating = 4;

    final json = {
      'id': 's1knt6za9kkfw1e867',
      'name': 'Kafe Kita',
      'description': 'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...',
      'pictureId': '25',
      'city': 'Gorontalo',
      'rating': 4
    };

    Restaurant result = Restaurant.fromJson(json);
    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });
}
