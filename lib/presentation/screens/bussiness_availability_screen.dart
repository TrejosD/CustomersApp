import 'package:clientes_app/config/tools/human_formats.dart';
import 'package:clientes_app/domain/entities/availability_entity.dart';
import 'package:clientes_app/infrastructure/repositories/availability_repository_impl.dart';
import 'package:clientes_app/presentation/providers/appointment_repository_provider.dart';
import 'package:clientes_app/presentation/providers/availability_repository_provider.dart';
import 'package:clientes_app/presentation/providers/bussiness_provider.dart';
import 'package:clientes_app/presentation/providers/current_user_appointment_provider.dart';
import 'package:clientes_app/presentation/providers/logged_user_id_provider.dart';
import 'package:clientes_app/presentation/widgets/appointment_tile.dart';
import 'package:clientes_app/presentation/widgets/set_appointment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BussinessAvailabilityScreen extends ConsumerStatefulWidget {
  final String bussID;
  const BussinessAvailabilityScreen({super.key, required this.bussID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BussinessAvailabilityScreenState();
}

class _BussinessAvailabilityScreenState
    extends ConsumerState<BussinessAvailabilityScreen> {
  late Future<List<Availability>> slots;
  @override
  void initState() {
    super.initState();
    final availabilityRepo = ref.read(availabilityRepositoryProvider);
    slots = availabilityRepo.getAvailabilityByBussinessId(widget.bussID);
  }

  void refreshAvailability(AvailabilityRepositoryImpl avaRepo) {
    slots = avaRepo.getAvailabilityByBussinessId(widget.bussID);
  }

  @override
  Widget build(BuildContext context) {
    final bussinessState = ref.watch(bussinessProvider(widget.bussID));
    final userId = ref.watch(userIdProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: slots,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) throw Exception(snapshot.error);
            if (snapshot.hasData && snapshot.data != null) {
              final List<Availability> listAvas = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(2),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  itemCount: listAvas.length,
                  itemBuilder: (context, index) {
                    final ava = listAvas[index];
                    // aca tenemos el head "tipo AppBar"
                    return Container(
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      HumanFormats.getTextDay(
                                          ava.dayDate.toString()),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  tileColor:
                                      const Color.fromARGB(255, 71, 77, 74),
                                  title: Text(
                                    bussinessState.buss!.name,
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Fecha: ${HumanFormats.dateHumanFormat(ava.dayDate.toString())}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios)),
                            ),
                            Divider(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: ava.spaceTime!.length,
                                itemBuilder: (context, index) {
                                  final avaSlot = ava.spaceTime![index];
                                  return GestureDetector(
                                    onTap: () async {
                                      // asi solamente si el espacio esta disponible, abre el Dialog para agendar el espacio
                                      if (avaSlot.isAvailable) {
                                        final appointmentService = ref.read(
                                            appointmentRepositoryProvider);
                                        final availabilityRepo = ref.read(
                                            availabilityRepositoryProvider);
                                        final productList =
                                            bussinessState.buss!.products;
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              SetAppointmentDialog(
                                                  productList: productList,
                                                  bussiness:
                                                      bussinessState.buss!,
                                                  userID: userId.id,
                                                  ava: ava,
                                                  avaSlots: avaSlot,
                                                  bussinessID: widget.bussID,
                                                  appointmentRepo:
                                                      appointmentService,
                                                  availabilityRepo:
                                                      availabilityRepo),
                                        ));
                                        if (mounted) {
                                          setState(() {
                                            ref.invalidate(
                                                currentUserAppointmentProvider);
                                            refreshAvailability(
                                                availabilityRepo);
                                          });
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 1),
                                      child: AppointmentTile(sloth: avaSlot),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ));
                  },
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
