import 'package:clientes_app/domain/datasources/bussiness_data_source.dart';
import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/domain/repositories/bussiness_repository.dart';

class BussinessRepositoryImpl extends BussinessRepository {
  final BussinessDataSource bussinessDataSource;
  BussinessRepositoryImpl({required this.bussinessDataSource});

  @override
  Future<List<Bussiness>> getAllBussiness() {
    return bussinessDataSource.getAllBussiness();
  }

  @override
  Future<Bussiness> getBussinessByID(String id) {
    return bussinessDataSource.getBussinessByID(id);
  }

  @override
  Future<List<Bussiness>> getBussinessesByTerm(String term) {
    return bussinessDataSource.getBussinessesByTerm(term);
  }
}
