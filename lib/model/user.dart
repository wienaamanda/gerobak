import 'package:meta/meta.dart';

class User {
  final String namaGerobak;
  final String rating;
  final String jarak;

  const User({
    @required this.namaGerobak,
    @required this.rating,
    @required this.jarak,
  });

  static User fromJson(json) => User(
        namaGerobak: json['namaGerobak'],
        rating: json['rating'],
        jarak: json['jarak'],
      );
}
