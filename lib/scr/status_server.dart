import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets/service/provider_socket.dart';

class StatusServer extends StatelessWidget {
  const StatusServer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSocket>(context);

    return Scaffold(
      body: Center(
        child: Container(
          child: Text(provider.socketOn['nombre']),
          //color: provider.serverStatus == ServerStatus.Online
          //    ? Colors.green
          //    : Colors.red,
          width: 200,
          height: 200,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Map<String, dynamic> data = {'nombre': 'flutter'};
        provider.socket.emit('mensajex', data);
      }),
    );
  }
}
