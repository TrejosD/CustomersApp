import 'package:clientes_app/infrastructure/datasources/notifications_db_datasource.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final NotificationsDbDatasource notificationDataSource =
      NotificationsDbDatasource();

  Future<void> initializeAndGetToken(
    String id,
    String deviceId,
    String platform,
  ) async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('Permiso otorgado por el usuario');
      }
      String? token = await _messaging.getToken();

      if (token != null) {
        if (kDebugMode) {
          notificationDataSource.postUserFCMToken(
            id,
            token,
            deviceId,
            platform,
          );
        }
        //*enviar el token al service
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('Permiso provisional concedido (IOS)');
        }
      } else {
        if (kDebugMode) {
          print('Permiso no fue consedido');
        }
      }
    }
  }
}
