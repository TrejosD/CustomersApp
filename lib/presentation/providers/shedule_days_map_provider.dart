import 'package:flutter_riverpod/flutter_riverpod.dart';

// este mapa lo usaremos para fabricar el UI, de acuerdo al valor numero de cada dia.
final scheduleDaysMapProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final List<Map<String, dynamic>> daysConfig = [
    {'label': 'L', 'value': 1},
    {'label': 'M', 'value': 2},
    {'label': 'K', 'value': 3},
    {'label': 'J', 'value': 4},
    {'label': 'V', 'value': 5},
    {'label': 'S', 'value': 6},
    {'label': 'D', 'value': 7},
  ];

  return daysConfig;
});
