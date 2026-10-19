abstract class NotificationsDataSource {
  Future<void> postUserFCMToken(
    String id,
    String token,
    String deviceId,
    String platform,
  );
}
