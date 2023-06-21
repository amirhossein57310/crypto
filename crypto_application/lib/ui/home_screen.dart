import 'dart:convert';
import 'package:crypto_application/data/const/constants.dart';
import 'package:crypto_application/data/model/crypto.dart';
import 'package:crypto_application/data/model/user.dart';
import 'package:crypto_application/ui/crypto_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  String title = 'loading...';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SpinKitWave(color: Colors.white, size: 80),
          ],
        ),
      ),
    );
  }

  Future<List<Crypto>> getData() async {
    // var uri = Uri.parse('https://jsonplaceholder.typicode.com/users/1');

    //  Response response = await get(uri);
    //  int id = jsonDecode(response.body)['id'];
    // String name = jsonDecode(response.body)['name'];
    //   String username = jsonDecode(response.body)['username'];

    //  User user = User(id, name, username);

    var response = await Dio().get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonObject) => Crypto.fromJsonObject(jsonObject))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CryproScreen(
            cryptoList: cryptoList,
          );
        },
      ),
    );
    return cryptoList;
  }
}
