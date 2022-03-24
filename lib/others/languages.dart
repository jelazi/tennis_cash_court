import 'package:get/route_manager.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'cs_Cz': {
          'hello': 'Ahoj',
          'nameApp': 'Počítání tenisových hodin',
          'search': 'Hledej',
          'fromDate': 'Od data: ',
          'toDate': 'Do data: ',
          'totalHours': 'Celkem hodin: ',
          'hours': ' hodin',
          'totalPrice': 'Celková cena: ',
          'nothingToPay': 'Nic k zaplacení!',
          'paymentAllHours': 'Zaplať',
          'currentPlayer': 'Aktuální hráč:',
          'namePlayer': 'Jméno hráče',
          'password': 'Heslo',
          'isAdmin': 'Je administrátor',
          'common': 'Obecné nastavení:',
          'hourPrice': 'Cena za hodinu',
          'currency': 'Měna',
          'language': 'Jazyk',
          'ok': 'Ok',
          'cancel': 'Zrušit',
          'enterNewPass': 'Vlož nové heslo',
          'enterNamePlayer': 'Vlož jméno hráče',
          'enterShortCurrency': 'Vlož zkrácený název měny',
          'enterHourPrice': 'Vlož cenu za hodinu',
        },
        'en_US': {
          'hello': 'Hello',
        },
      };
}
