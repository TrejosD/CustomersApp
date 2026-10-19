import 'package:clientes_app/domain/entities/appointment_entity.dart';
import 'package:clientes_app/domain/entities/space_time_entity.dart';

abstract class AppointmentRepository {
  Future<String> freeAppointmentSpace(String appointmentId);
  Future<List<Appointment>> getAppointmentByUserID(String id);
  Future<List<SpaceTimeEntity>> setAppointment(
    String id,
    String bussinessID,
    String customerID,
    String productID,
    DateTime dayDate,
    DateTime startTime,
    String slothID,
  );
}
