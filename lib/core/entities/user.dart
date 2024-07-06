import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final List<String>? conversations;

  User({
    required this.name,
    required this.password,
    this.conversations
  });
}