import 'package:clientes_app/domain/datasources/appointment_data_source.dart';
import 'package:clientes_app/domain/entities/appointment_entity.dart';
import 'package:clientes_app/domain/entities/space_time_entity.dart';
import 'package:clientes_app/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  final AppointmentDataSource appointmentDataSource;
  AppointmentRepositoryImpl({required this.appointmentDataSource});

  @override
  Future<List<SpaceTimeEntity>> setAppointment(
    String id,
    String bussinessID,
    String customerID,
    String productID,
    DateTime dayDate,
    DateTime startTime,
    String slothID,
  ) {
    return appointmentDataSource.setAppointment(
      id,
      bussinessID,
      customerID,
      productID,
      dayDate,
      startTime,
      slothID,
    );
  }

  @override
  Future<String> freeAppointmentSpace(String appointmentId) {
    return appointmentDataSource.freeAppointmentSpace(appointmentId);
  }

  @override
  Future<List<Appointment>> getAppointmentByUserID(String id) {
    return appointmentDataSource.getAppointmentByUserID(id);
  }
}
