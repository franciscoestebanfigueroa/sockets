import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets/model/model_bande.dart';
import 'package:sockets/service/provider_socket.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Banda> bandas = [
  Banda(nombre: 'Jesus Adrian Romero', votos: 1, id: DateTime.now().toString()),
  Banda(nombre: 'Ricardo M', votos: 1, id: DateTime.now().toString()),
  Banda(nombre: 'Redimi2', votos: 1, id: DateTime.now().toString()),
  Banda(nombre: 'Lili', votos: 1, id: DateTime.now().toString()),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSocket>(context);
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: provider.serverStatus == ServerStatus.Online
              ? const CircleAvatar(
                  child: Icon(Icons.signal_cellular_alt_outlined,
                      color: Colors.green),
                )
              : const CircleAvatar(
                  child: Icon(
                    Icons.signal_cellular_off,
                    color: Colors.red,
                  ),
                ),
        )
      ]),
      body: ListView.builder(
          itemCount: bandas.length,
          itemBuilder: (context, index) => _listadoBandas(bandas[index])),
    );
  }

  Dismissible _listadoBandas(Banda banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 10),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        color: Colors.red,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(banda.nombre.substring(0, 2)),
        ),
        title: Text(banda.nombre),
        trailing: Text(banda.votos.toString()),
      ),
    );
  }
}
