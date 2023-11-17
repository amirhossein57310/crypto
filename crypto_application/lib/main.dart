import 'package:crypto_application/data/bloc/crypto_bloc.dart';
import 'package:crypto_application/data/bloc/crypto_event.dart';
import 'package:crypto_application/di/di.dart';
import 'package:crypto_application/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInIt();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) {
          var bloc = CryptoBloc(locator.get());
          bloc.add(CryproResposneEvent());
          return bloc;
        },
        child: HomeScreen(),
      ),
    );
  }
}
