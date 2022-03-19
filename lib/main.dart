import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets/scr/scr.dart';
import 'package:sockets/service/provider_socket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderSocket(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {'home': (_) => Home(), 'status': (_) => const StatusServer()},
      ),
    );
  }
}
