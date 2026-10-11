import 'package:clientes_app/domain/datasources/appointment_data_source.dart';
import 'package:clientes_app/domain/entities/appointment_entity.dart';
import 'package:clientes_app/domain/entities/space_time_entity.dart';
import 'package:clientes_app/infrastructure/mappers/appointment_mapper.dart';
import 'package:clientes_app/infrastructure/mappers/user_appointment_mapper.dart';
import 'package:clientes_app/infrastructure/models/appointment_api/appointment_response.dart';
import 'package:clientes_app/infrastructure/models/appointment_api/appointmentdb.dart';
import 'package:dio/dio.dart';

class AppointmentDbDatasource extends AppointmentDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://appointmentservice-kl4u.onrender.com/citas'));
  @override
  Future<List<Appointment>> getAllAppointments() {
    // TODO: implement getAllAppointments
    throw UnimplementedError();
  }

// este metodo envia los datos para agendar un espacio, retorna el espacio agendado
  @override
  Future<List<SpaceTimeEntity>> setAppointment(
      String id,
      String bussinessID,
      String customerID,
      String productID,
      DateTime dayDate,
      DateTime startTime,
      String slothID) async {
    // todo la respuesta la manejo aca
    // response = Response ({"message":"Espacio para cita no disponible - check logs","error":"Bad Request","statusCode":400})
    final response = await dio.post('/appointment/$id', data: {
      'bussinessID': bussinessID,
      'customerID': customerID,
      'productID': productID,
      'dayDate': dayDate.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'slothID': slothID
    });
    final appointmentResponse = (response.data as List)
        .map((json) => AppointmentResponse.fromJson(json))
        .toList();
    final List<SpaceTimeEntity> appointment = appointmentResponse
        .map((app) => AppointmentMapper.appointmentRespToSpaceTime(app))
        .toList();
    return appointment;
  }

  @override
  Future<String> freeAppointmentSpace(String appointmentId) async {
    try {
      final response = await dio.delete('/appointment/$appointmentId');
      //todo manejar la hora actual vs la hora de la cita. NO SE DEBERIA ELIMINAR UNA CITA A MENOS DE UNA HORA DE INICIO *PODRIA REDUCIRLA A 45MIN
      // CONTACTO BUSSINESS OWNER
      return response.toString();
    } on DioException catch (e) {
      throw Exception('Error occured during deleting appointment ${e.message}');
    }
  }

  // este metodo retorna una lista de citas del usuario.
  @override
  Future<List<Appointment>> getAppointmentByUserID(String id) async {
    final response = await dio.get('/appointment/user/$id');
    final appointmentResponse = (response.data as List)
        .map((app) => AppointmentDb.fromJson(app))
        .toList();
    final List<Appointment> appointments = appointmentResponse
        .map((app) => UserAppointmentMapper.appointmentDbToEntity(app))
        .toList();
    return appointments;
  }
}
