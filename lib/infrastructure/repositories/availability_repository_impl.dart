import 'package:clientes_app/domain/datasources/availability_data_source.dart';
import 'package:clientes_app/domain/entities/availability_entity.dart';
import 'package:clientes_app/domain/repositories/availability_repository.dart';

class AvailabilityRepositoryImpl extends AvailabilityRepository {
  final AvailabilityDataSource availabilityDataSource;
  AvailabilityRepositoryImpl({required this.availabilityDataSource});
  @override
  Future<List<Availability>> getAvailabilityByBussinessId(String id) {
    return availabilityDataSource.getAvailabilityByBussinessId(id);
  }
}
