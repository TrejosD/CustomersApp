// aca se enlistan los metodos que necesito de los bussiness. Pero no se implementan.
import 'package:clientes_app/domain/entities/bussiness_entity.dart';

abstract class BussinessDataSource {
  Future<List<Bussiness>> getAllBussiness();
  Future<List<Bussiness>> getBussinessesByTerm(String term);
  Future<Bussiness> getBussinessByID(String id);
}
