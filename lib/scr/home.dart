import 'package:flutter/material.dart';
import 'package:sockets/model/model_bande.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final TextEditingController textcontroller = TextEditingController();
List<Banda> bandas = [
  Banda(nombre: 'Jesus Adrian Romero', votos: 1, id: DateTime.now().toString()),
  Banda(nombre: 'Ricardo M', votos: 1, id: DateTime.now().toString()),
  Banda(nombre: 'Redimi2', votos: 1, id: DateTime.now().toString()),
  Banda(nombre: 'Lili', votos: 1, id: DateTime.now().toString()),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addlist,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: bandas.length,
          itemBuilder: (context, index) => _listadoBandas(bandas[index])),
    );
  }

  void addlist() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              const Text(' Nuevo Banda'),
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                controller: textcontroller,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child:const Text('Salir')),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        bandas.add(Banda(
                            nombre: textcontroller.text,
                            votos: 0,
                            id: DateTime.now().toString()));
                        Navigator.pop(context);
                        textcontroller.clear();
                      });
                    },
                    child: const Text('add'),
                    
                  ),
                ],
              )
            ],
          );
        });
  }

  Dismissible _listadoBandas(Banda banda) {
    return Dismissible(
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
        leading: CircleAvatar(
          child: Text(
              banda.nombre[0].toUpperCase() + banda.nombre[1].toLowerCase()),
        ),
        title: Text(banda.nombre),
        trailing: Text(banda.votos.toString()),
      ),
    );
  }
}
