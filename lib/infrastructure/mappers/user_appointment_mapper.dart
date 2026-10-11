import 'package:clientes_app/domain/entities/appointment_entity.dart';

import '../models/appointment_api/appointmentdb.dart';

class UserAppointmentMapper {
  static Appointment appointmentDbToEntity(AppointmentDb app) => Appointment(
        id: app.id,
        bussinessID: app.bussinessId,
        customerID: app.customerId,
        productID: app.productId,
        startTime: app.startTime,
        slothID: app.slothId,
        endTime: app.endTime,
      );
}


/*
{
    "_id": "6abfed020dfe7b51a2174ede",
    "bussinessID": "6a9a2872551320b3485b3327",
    "customerID": "6abebcd1c088b6d56523cfee",
    "productID": "6a9a2872551320b3485b332a",
    "startTime": "2026-09-10T10:00:00.000Z",
    "slothID": "6aa056a2353c62f0e5a927db",
    "__v": 0,
    "endTime": "2026-09-10T10:30:00.000Z"
}
 */