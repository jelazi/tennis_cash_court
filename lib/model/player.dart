import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

// ignore: deprecated_member_use
@JsonSerializable()
class Player {
  String name;
  bool isAdmin = false;
  String password;

  Player(this.name, this.password);
  Player.withAdminRights(this.name, this.password) {
    isAdmin = true;
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
