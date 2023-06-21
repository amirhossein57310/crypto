import 'package:crypto_application/data/const/constants.dart';
import 'package:crypto_application/data/model/crypto.dart';
import 'package:crypto_application/data/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CryproScreen extends StatefulWidget {
  CryproScreen({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;

  @override
  State<CryproScreen> createState() => _CryproScreenState();
}

class _CryproScreenState extends State<CryproScreen> {
  List<Crypto>? cryptoList;
  bool state = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: greenColor,
      color: blackColor,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        List<Crypto> freshData = await getData();
        setState(() {
          cryptoList = freshData;
        });
      },
      child: _cryptoScreenBody(),
    );
  }

  Scaffold _cryptoScreenBody() {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: true,
        title: Text(
          'کیریپتو بازار',
          style: TextStyle(
            fontFamily: 'mr',
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  filterList(value);
                },
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: greenColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'اسم رمز ارز خود را سرچ بفرمایید',
                  contentPadding: EdgeInsets.only(right: 20),
                  hintStyle: TextStyle(
                    color: blackColor,
                    fontFamily: 'mr',
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: state,
              child: Text(
                'در حال آپدیت کردن رمزارزها',
                style: TextStyle(
                  color: greenColor,
                  fontFamily: 'mr',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _LIstTileItem(index);
                },
                itemCount: cryptoList!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _LIstTileItem(int index) {
    return ListTile(
      title: Text(
        cryptoList![index].name,
        style: TextStyle(
            color: greenColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        cryptoList![index].symbol,
        style: TextStyle(
            color: greyColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            cryptoList![index].rank.toString(),
            style: TextStyle(
                color: greyColor, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cryptoList![index].priceUsd.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: greyColor),
                ),
                Text(
                  cryptoList![index].changePercent24Hr.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _colorChangePrice(index),
                  ),
                ),
              ],
            ),
            SizedBox(width: 50, child: _changePercentTrend(index))
          ],
        ),
      ),
    );
  }

  Widget _changePercentTrend(int index) {
    return cryptoList![index].changePercent24Hr > 0
        ? Icon(
            Icons.trending_up,
            color: greenColor,
            size: 25,
          )
        : Icon(
            Icons.trending_down,
            color: redColor,
            size: 25,
          );
  }

  Color _colorChangePrice(int index) {
    return cryptoList![index].changePercent24Hr > 0 ? greenColor : redColor;
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
    return cryptoList;
  }

  Future<void> filterList(String value) async {
    if (value.isEmpty) {
      setState(() {
        state = true;
      });
      var result = await getData();
      setState(() {
        cryptoList = result;
        state = false;
      });
    }
    if (value.isNotEmpty) {
      setState(() {
        state = true;
      });
      var result = await getData();
      setState(() {
        cryptoList = result;
      });
      List<Crypto> cryptoResultList = [];
      cryptoResultList = cryptoList!.where((element) {
        return element.name.toLowerCase().contains(value.toLowerCase());
      }).toList();
      setState(() {
        cryptoList = cryptoResultList;
        state = false;
      });
    }
  }
}
