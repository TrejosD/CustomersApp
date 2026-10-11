// import 'package:clientes_app/domain/entities/availability_entity.dart';

import 'package:clientes_app/domain/entities/availability_entity.dart';

abstract class AvailabilityDataSource {
  Future<List<Availability>> getAvailabilityByBussinessId(String id);
  // tentativo metodo, no creo necesitarlo
  // Future<List<Availability>> getAvailabilityByBussinessIdForDate(String id, DateTime date);
}
