import 'package:clientes_app/domain/datasources/bussiness_data_source.dart';
import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/infrastructure/mappers/bussiness_mapper.dart';
import 'package:clientes_app/infrastructure/models/bussiness_api/bussiness_response.dart';
import 'package:dio/dio.dart';

// import '../../config/constants/environment.dart';

class BussinessDBDataSource extends BussinessDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://appointmentservice-kl4u.onrender.com/citas'));
// este metodo, retorna todos los negicios guardados en DB
  @override
  Future<List<Bussiness>> getAllBussiness() async {
    try {
      final response = await dio.get('/bussiness');
      final bussinessResponse = (response.data as List)
          .map((json) => BussinessResponse.fromJson(json))
          .toList();
      final List<Bussiness> bussiness = bussinessResponse
          .map((buss) => BussinessMapper.bussinessDbEntity(buss))
          .toList();
      return bussiness;
    } catch (e, stacktrace) {
      print('Error en get');
      print(e);
      print(stacktrace);
    }
    return [];
  }

  @override
  Future<Bussiness> getBussinessByID(String id) async {
    try {
      final response = await dio.get('/bussiness/$id');
      final bussinesResponse = BussinessResponse.fromJson(response.data);
      final bussiness = BussinessMapper.bussinessDbEntity(bussinesResponse);
      return bussiness;
    } on DioException catch (e, stacktrace) {
      print(stacktrace);
      throw Exception('Error buscando el bussiness ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado buscando el bussiness $e');
    }
  }

  @override
  Future<List<Bussiness>> getBussinessesByTerm(String term) async {
    try {
      final response = await dio.get('/bussiness/find/$term');
      final bussinessResponse = (response.data as List)
          .map((json) => BussinessResponse.fromJson(json))
          .toList();
      final List<Bussiness> bussiness = bussinessResponse
          .map((buss) => BussinessMapper.bussinessDbEntity(buss))
          .toList();
      return bussiness;
    } on DioException catch (e) {
      throw Exception("Bussines not found $e ");
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }
}
