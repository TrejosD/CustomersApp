import 'package:clientes_app/domain/entities/space_time_entity.dart';
import 'package:clientes_app/infrastructure/models/appointment_api/appointment_response.dart';

class AppointmentMapper {
  static SpaceTimeEntity appointmentRespToSpaceTime(
          AppointmentResponse avaSlot) =>
      SpaceTimeEntity(
          startTime: avaSlot.startTime,
          endTime: avaSlot.endTime,
          isAvailable: avaSlot.isAvailable,
          id: avaSlot.id);
}
