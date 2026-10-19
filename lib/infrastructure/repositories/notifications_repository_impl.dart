import 'package:clientes_app/domain/datasources/notifications_data_source.dart';
import 'package:clientes_app/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsDataSource notificationsDataSource;
  NotificationsRepositoryImpl({required this.notificationsDataSource});
  @override
  Future<void> postUserFCMToken(
    String id,
    String token,
    String deviceId,
    String platform,
  ) {
    return notificationsDataSource.postUserFCMToken(
      id,
      token,
      deviceId,
      platform,
    );
  }
}
