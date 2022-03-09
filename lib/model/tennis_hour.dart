import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class TennisHour {
  late double hours;
  late DateTime date;
  List partner = [];
  List<String> playerPayd = [];
  bool _isPayd = false;
  late String id;

  TennisHour(
      {required this.date, required this.hours, this.partner = const []}) {
    _generateId();
  }

  TennisHour.fromMap(Map map) {
    try {
      date =
          (map['date'] != null) ? DateTime.parse(map['date']) : DateTime.now();
      hours = (map['hours'] != null) ? (map['hours'] as int).toDouble() : 0.0;
      partner = (map['partner'] != null) ? map['partner'] : [];
      _isPayd = map['isSold'] == 'true' ? true : false;
      id = map['id'] ?? '';
    } catch (e) {
      logger.e(e);
      date = DateTime.now();
      hours = 2.0;
      var uuidGener = Uuid();
      id = uuidGener.v1();
    }
  }

  bool get isPayd {
    return _isPayd;
  }

  set isPayd(bool isPayd) {
    _isPayd = isPayd;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'hours': hours,
      'date': date.toString(),
      'partner': partner,
      'isSold': _isPayd.toString(),
      'id': id,
    };
    return map;
  }

  String getAllChars() {
    //for filtering
    String allChars = '';
    allChars = hours.toString();
    DateFormat formatter = DateFormat('dd. MM. yyyy');
    allChars += formatter.format(date);
    allChars += partner.join();
    return allChars;
  }

  void _generateId() {
    var uuidGener = Uuid();
    id = uuidGener.v1();
  }

  bool updateDatas(TennisHour hourUpdate) {
    if (hourUpdate.id != id) return false;
    _isPayd = hourUpdate.isPayd;
    hours = hourUpdate.hours;
    partner = hourUpdate.partner;
    date = hourUpdate.date;
    return true;
  }
}
