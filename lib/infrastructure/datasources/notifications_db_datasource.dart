import 'package:clientes_app/domain/datasources/notifications_data_source.dart';
import 'package:dio/dio.dart';

class NotificationsDbDatasource extends NotificationsDataSource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://appointmentservice-kl4u.onrender.com/citas'),
  );
  @override
  Future<void> postUserFCMToken(
    String id,
    String token,
    String deviceId,
    String platform,
  ) async {
    try {
      await dio.post(
        '/notifications/',
        data: {
          'userId': id,
          'pushToken': token,
          'deviceId': deviceId,
          'platform': platform,
        },
      );
    } on DioException catch (e) {
      throw Exception('User FCM token not save, message: ${e.message}');
    }
  }
}
