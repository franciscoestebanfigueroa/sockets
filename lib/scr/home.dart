import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:sockets/model/model_bande.dart';
import 'package:sockets/service/provider_socket.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSocket>(
      context,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //provider.listadoBandas = [];
          showDialog(
              context: context,
              builder: (context) {
                final controlerText = TextEditingController();
                return AlertDialog(
                  actions: [
                    TextField(
                      controller: controlerText,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              provider.socket.emit(
                                  'nuevaBanda', {'name': controlerText.text});
                              Navigator.pop(context);
                            },
                            child: const Text('Add')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Salir')),
                      ],
                    )
                  ],
                );
              });
        },
      ),
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 2,
            child: provider.dataMap.isNotEmpty
                ? PieChart(
                    ringStrokeWidth: 20,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    chartType: ChartType.ring,
                    dataMap: provider.dataMap,
                  )
                : const SizedBox(),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
                itemCount: provider.listadoBandas.length,
                itemBuilder: (context, index) =>
                    _listadoBandas(provider.listadoBandas[index])),
          ),
        ],
      ),
    );
  }

  Dismissible _listadoBandas(Banda banda) {
    final provider = Provider.of<ProviderSocket>(
      context,
    );

    return Dismissible(
      onDismissed: (direction) {
        print(banda.id);
        provider.socket.emit('eliminarBanda', {'id': banda.id.toString()});
      },
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 10),
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
        onTap: () {
          provider.socket.emit('votacion', {'id': banda.id});
        },
        leading: CircleAvatar(
          child: Text(banda.name.substring(0, 2)),
        ),
        title: Text(banda.name),
        trailing: Text(banda.votos.toString()),
      ),
    );
  }
}
