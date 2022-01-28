import 'package:uuid/uuid.dart';

class TennisHour {
  late double hours;
  late DateTime date;
  late String partner;
  bool _isSold = false;
  late String id;

  bool get isSold {
    return _isSold;
  }

  set isSold(bool isSold) {
    _isSold = isSold;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'hours': hours,
      'date': date.toString(),
      'partner': partner,
      'isSold': _isSold.toString(),
      'id': id,
    };
    return map;
  }

  void _generateId() {
    var uuidGener = Uuid();
    id = uuidGener.v1();
  }

  TennisHour(this.date, this.hours, this.partner) {
    _generateId();
  }

  TennisHour.fromMap(Map map) {
    date = (map['date'] != null) ? DateTime.parse(map['date']) : DateTime.now();
    hours = (map['hours'] != null) ? double.parse(map['hours'].toString()) : 0;
    partner = map['partner'] ?? '';
    _isSold = map['isSold'] == 'true' ? true : false;
    id = map['id'] ?? '';
  }

  bool updateDatas(TennisHour hourUpdate) {
    if (hourUpdate.id != id) return false;
    _isSold = hourUpdate.isSold;
    hours = hourUpdate.hours;
    partner = hourUpdate.partner;
    date = hourUpdate.date;
    return true;
  }
}
