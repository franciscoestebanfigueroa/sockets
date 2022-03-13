import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

enum ServerStatus {
  Online,
  Connecting,
  Offline,
}

class ProviderSocket extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  Map<String, dynamic> _datax = {};
  ProviderSocket() {
    conectar();
    // Dart client
  }

  IO.Socket get socket => _socket;

  ServerStatus get serverStatus => _serverStatus;

  Map<String, dynamic> get socketOn {
    _socket.on('mensajex', (data) {
      _datax = data;
      notifyListeners();
    });

    return _datax;
  }

  void conectar() {
    _socket = IO.io(
        'http://localhost:3000/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .build());

    _socket.connect();

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
      // socket.emit('msg', 'test');
    });
    _socket.onError((data) => print(data));
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //socket.on('fromServer', (_) => print(_));
    //socket.emit('mensajex', 'saludos de flutter');
  }
}
