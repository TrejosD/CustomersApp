import 'package:clientes_app/config/tools/human_formats.dart';
import 'package:clientes_app/domain/entities/space_time_entity.dart';
import 'package:flutter/material.dart';

class AppointmentTile extends StatelessWidget {
  final SpaceTimeEntity sloth;
  const AppointmentTile({super.key, required this.sloth});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Column(
            children: [
              Text(
                HumanFormats.timeHumanFormat(sloth.startTime.toString()),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                HumanFormats.timeHumanFormat(sloth.endTime.toString()),
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                  color: sloth.isAvailable
                      ? Colors.grey.shade50
                      : Colors.redAccent.shade100,
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                sloth.isAvailable ? 'Click para agendar' : 'No disponible',
                style: TextStyle(fontSize: 18),
              )),
          SizedBox(
            width: 44,
          )
        ],
      ),
      subtitle: Divider(),
    );
  }
}
