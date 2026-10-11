import 'package:clientes_app/domain/entities/appointment_entity.dart';
import 'package:clientes_app/presentation/providers/appointment_repository_provider.dart';
import 'package:clientes_app/presentation/providers/logged_user_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserAppointmentProvider = FutureProvider((ref) {
  final userState = ref.read(userIdProvider);
  final appointmentDataSource = ref.watch(appointmentRepositoryProvider);
  Future<List<Appointment>> getAppointmentsByUser() async {
    final appoinments =
        await appointmentDataSource.getAppointmentByUserID(userState.id);
    return appoinments;
  }

  return getAppointmentsByUser();
});
