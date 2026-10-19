import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este mapa lo usaremos para fabricar el UI, de acuerdo al valor numero de cada dia.
final scheduleDaysMapProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final List<Map<String, dynamic>> daysConfig = [
    {'label': 'daysLabelList.1'.tr(), 'value': 1},
    {'label': 'daysLabelList.2'.tr(), 'value': 2},
    {'label': 'daysLabelList.3'.tr(), 'value': 3},
    {'label': 'daysLabelList.4'.tr(), 'value': 4},
    {'label': 'daysLabelList.5'.tr(), 'value': 5},
    {'label': 'daysLabelList.6'.tr(), 'value': 6},
    {'label': 'daysLabelList.7'.tr(), 'value': 7},
  ];

  return daysConfig;
});
