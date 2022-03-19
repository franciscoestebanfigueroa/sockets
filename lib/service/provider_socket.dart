import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:sockets/model/model_bande.dart';

enum ServerStatus {
  Online,
  Connecting,
  Offline,
}

class ProviderSocket extends ChangeNotifier {
  List<Banda> bandas = [
    Banda(name: 'Jesus Adrian Romero', votos: 1, id: DateTime.now().toString()),
    Banda(name: 'Ricardo M', votos: 1, id: DateTime.now().toString()),
    Banda(name: 'Redimi2', votos: 1, id: DateTime.now().toString()),
    Banda(name: 'Lili', votos: 1, id: DateTime.now().toString()),
  ];
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  List<Banda> _listadoBandas = [];
  Map<String, double> _dataMap = {};

  Map<String, double> get dataMap {
    return _dataMap;
  }

  set listadoBandas(List<Banda> banda) {
    _listadoBandas = banda;
    notifyListeners();
  }

  List<Banda> get listadoBandas {
    return _listadoBandas;
  }

  ProviderSocket() {
    conectar();
    // Dart client
  }

  IO.Socket get socket => _socket;

  ServerStatus get serverStatus => _serverStatus;

  void socketOn() {
    //  print('listado  $listadoBandas');
    _socket.on('datos', (data) {
      // print('llego data nuevo $data');
      listadoBandas = [];
      for (var x in data['bandas']) {
        listadoBandas.add(Banda.fromMapa(x));
      }
      dataMap.clear();
      listadoBandas.forEach((key) {
        _dataMap.putIfAbsent(key.name, () => key.votos.toDouble());
      });

      //for (Banda item in listadoBandas) {
      //  print(item.votos);
      //}

      notifyListeners();
    });
  }

  void conectar() {
    print('inst conectar');
    _socket = IO.io(
        'http://localhost:3000/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .build());

    //   _socket.connect();
    socket.close();
    socket.connect();

    _socket.onConnect((_) {
      print('conectada ${listadoBandas.length}');

      socketOn();

      _serverStatus = ServerStatus.Online;
      notifyListeners();
      // socket.emit('msg', 'test');
    });
    _socket.onError((data) => print(data));
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;

      listadoBandas = [];
      listadoBandas = bandas;

      print('deconectado ${listadoBandas.length} ');
      notifyListeners();
    });

    //socket.on('fromServer', (_) => print(_));
    //socket.emit('mensajex', 'saludos de flutter');
  }
}
