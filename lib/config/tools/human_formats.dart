import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HumanFormats {
  static void initLocale() {
    initializeDateFormatting('es');
  }

  static String dateHumanFormat(String rawDate) {
    DateTime date = DateTime.parse(rawDate).toLocal();

    return DateFormat("d 'de' MMMM", 'es').format(date);
  }

  static String timeHumanFormat(String rawTime) {
    DateTime date = DateTime.parse(rawTime);

    return DateFormat('h:mm a').format(date);
  }

  static String getTextDay(String rawDate) {
    DateTime date = DateTime.parse(rawDate).toLocal();

    String day = DateFormat('E', 'es').format(date);
    return day.replaceAll('.', '').toUpperCase();
  }

// todo, estoy tratando de construir un metodo para convertir horas 24h => 12h
  static String set24hTo12h(String time) {
    final DateTime date = DateTime.parse(time);
    return DateFormat.jm().format(date);
  }
}
