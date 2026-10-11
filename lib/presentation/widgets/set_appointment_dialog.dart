import 'package:clientes_app/domain/entities/availability_entity.dart';
import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/domain/entities/product.dart';
import 'package:clientes_app/domain/entities/space_time_entity.dart';
import 'package:clientes_app/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:clientes_app/infrastructure/repositories/availability_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SetAppointmentDialog extends ConsumerStatefulWidget {
  final List<Product> productList;
  final Bussiness bussiness;
  final String bussinessID;
  final String userID;
  final Availability ava;
  final SpaceTimeEntity avaSlots;
  final AppointmentRepositoryImpl appointmentRepo;
  final AvailabilityRepositoryImpl availabilityRepo;
  const SetAppointmentDialog(
      {super.key,
      required this.productList,
      required this.bussiness,
      required this.userID,
      required this.ava,
      required this.avaSlots,
      required this.bussinessID,
      required this.appointmentRepo,
      required this.availabilityRepo});

  @override
  ConsumerState<SetAppointmentDialog> createState() =>
      _SetAppointmentDialogState();
}

class _SetAppointmentDialogState extends ConsumerState<SetAppointmentDialog> {
  bool error = false;
  String productID = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enviar solicitud de espacio'),
            SizedBox(
              height: 10,
            ),
            DropdownMenu(
              initialSelection: null,
              onSelected: (value) {
                productID = value ?? '';
                error = false;
                setState(() {});
              },
              dropdownMenuEntries: widget.productList.map((product) {
                return DropdownMenuEntry(
                    value: product.id, label: product.name);
              }).toList(),
            ),
            error
                ? Text(
                    'Debes Seleccionar un servicio',
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Text('Cancelar')),
                IconButton.filled(
                    onPressed: () async {
                      if (productID.isEmpty || productID.trim().isEmpty) {
                        error = true;
                        setState(() {});
                        return;
                      }
                      // todo me falta solo el customerID, para terminar la solicitud
                      // con este appResponse, voy a manejar la respuesta que todo salio bien o fallo
                      try {
                        await widget.appointmentRepo.setAppointment(
                            widget.ava.id!,
                            widget.bussinessID,
                            widget.userID,
                            productID,
                            widget.ava.dayDate!,
                            widget.avaSlots.startTime,
                            widget.avaSlots.id);
                        if (mounted) {
                          Navigator.of(context).pop();
                          showSuccessAlert(
                              context, 'Cita confirmada exitosamente');
                        }
                      } on DioException catch (e) {
                        String dbMessage = '';
                        if (e.response != null) {
                          print('ACA TENEMOS EL ERROR');
                          print(e.response!.statusCode);
                          if (e.response!.statusCode == 400) {
                            dbMessage = 'Espacio para cita no disponible';
                          }
                          if (e.response!.statusCode == 404) {
                            dbMessage =
                                'Ventana de tiempo insuficiente para el producto seleccionado';
                          }
                          if (e.response!.statusCode == 409) {
                            dbMessage =
                                'Lo sentimos. Espacio seleccionado ya fue ocupado';
                          }
                        }
                        if (mounted) {
                          // mostrarmos alerta, espacio no disponible
                          showAlertError(context,
                              buss: widget.bussiness,
                              title: 'Espacio ocupado',
                              message: '''$dbMessage 
                                  Por favor, selecciona otro horario''');
                        } else {
                          if (mounted) {
                            showAlertError(context,
                                buss: widget.bussiness,
                                title: 'Error de red',
                                message: 'Intentalo de nuevo más tarde');
                          }
                        }
                      } catch (e, stacktrace) {
                        print('No fue DioException');
                        print(e);
                        print(stacktrace);
                        if (mounted) {
                          showAlertError(context,
                              buss: widget.bussiness,
                              title: 'Error',
                              message: 'Ocurrio un problema inesperado');
                        }
                      }
                    },
                    icon: Text('Aceptar'))
              ],
            )
          ],
        ),
      )),
    );
  }
}

void showAlertError(BuildContext context,
    {required String title, required String message, required Bussiness buss}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => {context.push('/bussiness/ava/${buss.id}')},
              child: const Text(
                'Entendido',
                style: TextStyle(color: Colors.red),
              ))
        ],
      );
    },
  );
}

void showSuccessAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Todo listo!',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.green),
              ))
        ],
      );
    },
  );
}
