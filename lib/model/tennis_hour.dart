class TennisHour {
  double hours;
  DateTime date;
  String partner;
  bool _isSold = false;

  bool get isSold {
    return _isSold;
  }

  set isSold(bool isSold) {
    _isSold = isSold;
  }

  TennisHour(this.date, this.hours, this.partner);
}
