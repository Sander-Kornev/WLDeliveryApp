
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {

  User({required this.id, required this.fullname, required this.email});

  User.fromJson(Map json)
      : fullname = json['fullname'],
        email = json['email'],
        id = json['id'];

  update(Map json) {
    fullname = json['fullname'];
    email = json['email'];
    id = json['id'];
  }

  @HiveField(0)
  String fullname;

  @HiveField(1)
  String email;

  @HiveField(2)
  int id;
}