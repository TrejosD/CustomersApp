import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/presentation/providers/shedule_days_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BussinessCard extends ConsumerWidget {
  final Bussiness buss;
  const BussinessCard({super.key, required this.buss});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> getDaysLabel(List<int> scheduleDays) {
      final dayConfig = ref.read(scheduleDaysMapProvider);
      final List<String> dayList = [];
      for (var day in scheduleDays) {
        final match = dayConfig.firstWhere((item) => item['value'] == day);
        final String label = match['label'];
        dayList.add(label);
      }
      return dayList;
    }

    String setDaysRange(List<int> scheduleDays) {
      final list = getDaysLabel(scheduleDays);
      if (list.isEmpty) return '';
      if (list.length == 1) return list.first;
      return '${list.first}-${list.last}';
    }

    return Card(
      borderOnForeground: false,
      elevation: 2,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          children: [
            Container(
              height: 124,
              width: 140,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 136, 149, 152),
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all()),
              padding: EdgeInsets.all(12),
              child: Center(
                  child: Text(
                buss.name,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            ),
            Spacer(),
            Column(
              children: [
                Text(buss.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(setDaysRange(buss.schedule.days),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '${buss.schedule.startYourney.toString()}: am - ${buss.schedule.endYourney.toString()}: pm',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text('Servicios: '),
                SizedBox(
                  height: 24,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: buss.products.length,
                    itemBuilder: (context, index) {
                      final product = buss.products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(product.name),
                      );
                    },
                  ),
                ),
                Text(buss.address)
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
