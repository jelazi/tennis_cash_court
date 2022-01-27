class TennisHour {
  late double hours;
  late DateTime date;
  late String partner;
  late bool _isSold = false;

  bool get isSold {
    return _isSold;
  }

  set isSold(bool isSold) {
    _isSold = isSold;
  }

  Map toMap() {
    Map map = {
      'hours': hours,
      'date': date.toString(),
      'partner': partner,
      'isSold': _isSold.toString()
    };
    return map;
  }

  TennisHour(this.date, this.hours, this.partner);

  TennisHour.fromMap(Map map) {
    date = (map['date'] != null) ? DateTime.parse(map['date']) : DateTime.now();
    hours = (map['hours'] != null) ? double.parse(map['hours'].toString()) : 0;
    partner = map['partner'] ?? '';
    _isSold = map['isSold'] == 'true' ? true : false;
  }
}
