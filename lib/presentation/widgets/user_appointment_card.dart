import 'package:clientes_app/config/tools/human_formats.dart';
import 'package:clientes_app/domain/entities/appointment_entity.dart';
import 'package:clientes_app/presentation/providers/appointment_repository_provider.dart';
import 'package:clientes_app/presentation/providers/bussiness_repository_provider.dart';
import 'package:clientes_app/presentation/providers/current_user_appointment_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserAppointmentCard extends ConsumerWidget {
  final Appointment app;
  const UserAppointmentCard({super.key, required this.app});

  void showConfirmationAlert(BuildContext ctxt, WidgetRef ref) {
    showDialog(
      context: ctxt,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'cancelAppointment'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          content: Text(
            'ensureCancelation'.tr(),
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
                onPressed: () => context.pop(), child: Text('cancel'.tr())),
            IconButton.filledTonal(
                onPressed: () async {
                  await ref
                      .read(appointmentRepositoryProvider)
                      .freeAppointmentSpace(app.id!);
                  ref.invalidate(currentUserAppointmentProvider);
                  context.pop();
                },
                icon: Text(
                  'accept'.tr(),
                  style: TextStyle(color: Colors.green),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle style =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    final buss = ref
        .read(bussinessRepositoryProvider)
        .getBussinessByID(app.bussinessID!);
    return FutureBuilder(
      future: buss,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        if (snapshot.hasData && snapshot.data != null) {
          final bussiness = snapshot.data!;
          final products = bussiness.products;
          final product = products
              .firstWhere((prdtc) => prdtc.id.toString() == app.productID);
          return Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      bussiness.name,
                      style: style,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          showConfirmationAlert(context, ref);
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                        ))
                  ]),
                  Row(
                    children: [
                      Text(
                        HumanFormats.timeHumanFormat(app.startTime.toString()),
                        style: style,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '--',
                        style: style,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        product.name,
                        style: style,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
