// import 'package:clientes_app/sdomain/entities/availability_entity.dart';

abstract class AvailabilityRepository {
  Future<Iterable<void>> getAvailabilityByBussinessId(String id);
  // tentativo metodo, no creo necesitarlo
  // Future<List<Availability>> getAvailabilityByBussinessIdForDate(String id, DateTime date);
}
