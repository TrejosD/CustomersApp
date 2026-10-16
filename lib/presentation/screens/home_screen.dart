// home deberia ser, donde se encutran los negocios. 0 el screen de favoritos.
// si algo asi como entrar a DIDI, que lo primero son los restaurates.
// todo buscar como cambiar un screen de home de manera dinamica
import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:clientes_app/presentation/providers/bussiness_list_provider.dart';
import 'package:clientes_app/presentation/providers/current_user_appointment_provider.dart';
import 'package:clientes_app/presentation/providers/logged_user_id_provider.dart';
import 'package:clientes_app/presentation/widgets/bussiness_card.dart';
import 'package:clientes_app/presentation/widgets/side_option_tile.dart';
import 'package:clientes_app/presentation/widgets/user_appointment_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List> contentResponse;
  final TextEditingController controller = TextEditingController();
  String term = '';
  @override
  void initState() {
    super.initState();
    controller.addListener(clearBussinessSearch);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submitBussinessSearch(String terms) {
    term = terms;
    ref.invalidate(bussinessListProvider);
  }

  void clearBussinessSearch() {
    if (controller.text == '') {
      submitBussinessSearch('');
    }
  }

  @override
  Widget build(BuildContext context) {
    term = controller.text;
    final appointmentList = ref.watch(currentUserAppointmentProvider);
    final prefs = KeyValueStorageServiceImpl.prefs;
    AsyncValue<List<Bussiness>> bussinessList = ref.watch(
      bussinessListProvider(term),
    );
    final userState = ref.watch(userIdProvider);

    final localeList = [
      {'value': 'auto', 'label': 'Auto'},
      {'value': 'en', 'label': 'Ingles'},
      {'value': 'es', 'label': 'Español'},
      {'value': 'de', 'label': 'Aleman'},
      {'value': 'pt', 'label': 'Portuges'},
    ];
    final savedLocale = prefs.getString('locale');
    String? getLocaleLabel(savedLocale) {
      if (savedLocale != '' && savedLocale != null) {
        final match = localeList.firstWhere(
          (item) => item['value'] == savedLocale,
        );
        return match['label'];
      }
      return null;
    }

    void onLanguajeSelected(locale) async {
      if (locale == 'Automatico') {
        await prefs.remove('locale');
        Restart.restartApp();
      } else {
        await prefs.setString('locale', locale.toString());
        Restart.restartApp();
      }
    }

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(8),
    );

    const borderRadius = Radius.circular(15);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
            );
          },
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border.copyWith(
                borderSide: BorderSide(color: Colors.red.shade800),
              ),
              focusedErrorBorder: border.copyWith(
                borderSide: BorderSide(color: Colors.red.shade800),
              ),
              isDense: true,
              hintText: 'searchNameDescription'.tr(),
            ),
            controller: controller,
            onFieldSubmitted: (value) => submitBussinessSearch(value),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              submitBussinessSearch(controller.text);
            },
            icon: Icon(Icons.search_rounded),
          ),
        ],
      ),
      // *arriba del drawer seria una tarjeta de usuario, y abajo las opciones de settings
      // abajo van las opciones lenguaje, thema, politicas.
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 231, 241, 249),
                    offset: Offset(0.1, 0.7),
                    blurRadius: 0.3,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.contacts, size: 42),
                  ),
                  Text(userState.name),
                  Text(userState.email),
                ],
              ),
            ),
            Divider(),
            // todo Archivo de traduccion Drawer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Dark Theme'),
                      Spacer(),
                      Switch(value: false, onChanged: null),
                    ],
                  ),
                  SideOptionTile(
                    textStyle: TextStyle(fontSize: 18),
                    hintText: getLocaleLabel(savedLocale) ?? 'Auto',
                    initialSelection:
                        getLocaleLabel(savedLocale) ?? 'Automatico',
                    dropDownMenuExtries: localeList,
                    title: 'Lenguaje',
                    icon: Icons.language,
                    onSelected: (locale) async => onLanguajeSelected(locale),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          appointmentList.when(
            skipLoadingOnReload: true,
            data: (data) {
              return SizedBox(
                height: 86,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final app = data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 6,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        width: 220,
                        child: UserAppointmentCard(app: app),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              print(error);
              return SizedBox();
            },
            loading: () {
              return SizedBox();
            },
          ), // *aca se debe crear la lista de NegociosFavoritos.
          bussinessList.when(
            error: (error, stackTrace) {
              print(error);
              return SizedBox();
            },
            loading: () => Center(child: CircularProgressIndicator()),
            data: (data) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final buss = data[index];
                    return GestureDetector(
                      onTap: () => context.push('/bussiness/ava/${buss.id}'),
                      child: BussinessCard(buss: buss),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
