import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/legacy.dart';

final deviceDataProvider =
    StateNotifierProvider<DeviceDataNotifier, DeviceDataState>((ref) {
      return DeviceDataNotifier();
    });

class DeviceDataNotifier extends StateNotifier<DeviceDataState> {
  DeviceDataNotifier() : super(DeviceDataState()) {
    getDeviceData();
  }
  Future<void> getDeviceData() async {
    String deviceId = '';
    String platform = '';
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        platform = 'android';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        platform = 'ios';
      }
    } catch (e) {
      print('Error obteniendo datos del dispositivo: $e');
    }
    state = state.copyWith(deviceId: deviceId, platform: platform);
  }
}

class DeviceDataState {
  final String deviceId;
  final String platform;

  DeviceDataState({this.deviceId = '', this.platform = ''});

  DeviceDataState copyWith({String? deviceId, String? platform}) =>
      DeviceDataState(
        deviceId: deviceId ?? this.deviceId,
        platform: platform ?? this.platform,
      );
}
