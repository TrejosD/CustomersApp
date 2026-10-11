import 'package:clientes_app/domain/entities/availability_entity.dart';
import 'package:clientes_app/domain/entities/space_time_entity.dart';
import 'package:clientes_app/infrastructure/models/availability_api/availability_response.dart';

class AvailabilityMapper {
  static Availability availabilitySlotToEntity(AvailabilityResponse avaSlot) =>
      Availability(
        id: avaSlot.id,
        dayDate: avaSlot.dayDate,
        bussinessID: avaSlot.bussinessId,
        spaceTime: avaSlot.slots
            .map((slot) => availabilitySlotToSpaceTime(slot))
            .toList(),
      );

  static SpaceTimeEntity availabilitySlotToSpaceTime(
          AvailabilitySlot avaSlot) =>
      SpaceTimeEntity(
          startTime: avaSlot.startTime,
          endTime: avaSlot.endTime,
          isAvailable: avaSlot.isAvailable,
          id: avaSlot.id);
}

/*
"_id": "6a9ef5f04a76e342c163fe62",
        "bussinessID": "6a9a2872551320b3485b332d",
        "dayDate": "2026-09-08T17:35:43.101Z",
        "slots": [
            {
                "startTime": "2026-09-08T09:00:00.000Z",
                "endTime": "2026-09-08T10:00:00.000Z",
                "isAvailable": true,
                "_id": "6a9ef5f04a76e342c163fe63"
            },
 */
