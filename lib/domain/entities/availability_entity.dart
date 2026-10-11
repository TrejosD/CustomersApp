// todo estructura del spacetime
import 'package:clientes_app/domain/entities/space_time_entity.dart';

class Availability {
  String? id;
  String? bussinessID;
  DateTime? dayDate;
  List<SpaceTimeEntity>? spaceTime;

  Availability({this.id, this.bussinessID, this.dayDate, this.spaceTime});
}
// asi se ve el objeto spaceTime
/**
"startTime":{"$date":"2026-08-31T17:00:00Z"},
"endTime":{"$date":"2026-08-31T17:30:00Z"},
"isAvailable":false,"_id":{"$oid":"6a923bf5b29274936ead2adb"},
"reservationId":"6a933284e7982bca8816168b"},
{"startTime":{"$date":"2026-08-31T18:00:00Z"},"
endTime":{"$date":"2026-08-31T19:00:00Z"},
"isAvailable":true,"_id":{"$oid":"6a923bf5b29274936ead2adc"}}
 */
