import 'package:clientes_app/domain/datasources/availability_data_source.dart';
import 'package:clientes_app/domain/entities/availability_entity.dart';
import 'package:clientes_app/infrastructure/mappers/availability_mapper.dart';
import 'package:clientes_app/infrastructure/models/availability_api/availability_response.dart';
import 'package:dio/dio.dart';

class AvailabilityDbDataSource extends AvailabilityDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://appointmentservice-kl4u.onrender.com/citas'));
  // este metodo consulta los espacios disponibles para cita de un negocio, retorna una lista de dias, con una lista de espacios por dia.
  @override
  Future<List<Availability>> getAvailabilityByBussinessId(String id) async {
    try {
      final response = await dio.get('/availability/bussiness/$id');
      final availabilityResponse = (response.data as List)
          .map((json) => AvailabilityResponse.fromJson(json))
          .toList();
// el availability response es una lista de availabilitiesResponse. Eso lo paso por el mapper, para tener una lista de mis entidad Ava.
      final List<Availability> slots = availabilityResponse
          .map((item) => AvailabilityMapper.availabilitySlotToEntity(item))
          .toList();
      return slots;
    } catch (e, stacktrace) {
      print('Availablity by bussiness error');
      print(e);
      print(stacktrace);
    }
    throw Exception('Error buscando slots');
  }
}
