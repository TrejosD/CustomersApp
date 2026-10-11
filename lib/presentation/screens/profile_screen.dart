// screen muestra info del cliente, y puede ser editada.
// posiblemente crear un form activable, toggle Edit? or not
import 'package:clientes_app/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Card info
    Negocios Favoritos.
    Citas activas.
    */
    final Profile profile = Profile(name: 'Camila', gender: Gender.woman);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
        actions: [Icon(Icons.manage_accounts)],
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text(profile.name),
                Text(profile.lastName ?? ''),
                Text('Gender'),
              ],
            ),
          ),
          ListView(
              // todo convertir en builder.
              // recibir un objeto tipo favorites = List<Bussiness>
              // de esta lista mostrar Nombre - Tipo
              // gesture detector ir al negocio
              ),
          SizedBox(
              // Cita activa
              ),
        ],
      ),
    );
  }
}
