import '../constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

// ignore: deprecated_member_use
@JsonSerializable()
class Player {
  String name;
  bool _isAdmin = false;
  String password;

  bool get isAdmin {
    return _isAdmin;
  }

  Player(this.name, this.password);
  Player.withAdminRights(this.name, this.password) {
    _isAdmin = true;
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
