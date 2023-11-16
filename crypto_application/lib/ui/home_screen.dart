import 'package:crypto_application/data/bloc/crypto_bloc.dart';
import 'package:crypto_application/data/bloc/crypto_event.dart';
import 'package:crypto_application/data/bloc/crypto_state.dart';
import 'package:crypto_application/data/const/constants.dart';
import 'package:crypto_application/data/model/crypto.dart';
import 'package:crypto_application/di/di.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            var bloc = CryptoBloc(locator.get());
            bloc.add(CryproResposneEvent());
            return bloc;
          },
          child: ContentWidget(),
        ),
      ),
    );
  }
}

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
  });

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  bool click = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CryptoBloc, CryptoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is CryptoLoadingState) ...{
              Image.asset('assets/images/logo.png'),
              SpinKitWave(color: Colors.white, size: 80),
            },
            if (state is CryproResponseState) ...{
              state.response.fold(
                (l) {
                  return Text(l);
                },
                (r) {
                  return Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) async {
                              context
                                  .read<CryptoBloc>()
                                  .add(CryptoResponseFilterEvent(value));
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
                          visible: click,
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
                              return _LIstTileItem(index, r);
                            },
                            itemCount: r.length,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            },
            if (state is CryptoFilterState) ...{
              state.response.fold(
                (error) => Text('Error: $error'),
                (cryptoList) {
                  return Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) async {
                              context
                                  .read<CryptoBloc>()
                                  .add(CryptoResponseFilterEvent(value));
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
                          visible: click,
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
                              return _LIstTileItem(index, cryptoList);
                            },
                            itemCount: cryptoList.length,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            },
          ],
        );
      },
    );
  }

  Widget _LIstTileItem(int index, List<Crypto> cryptoList) {
    return ListTile(
      title: Text(
        cryptoList[index].name,
        style: TextStyle(
            color: greenColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        cryptoList[index].symbol,
        style: TextStyle(
            color: greyColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            cryptoList[index].rank,
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
                  cryptoList[index].priceUsd.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: greyColor),
                ),
                Text(
                  cryptoList[index].changePercent24Hr.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _colorChangePrice(index, cryptoList),
                  ),
                ),
              ],
            ),
            SizedBox(width: 50, child: _changePercentTrend(index, cryptoList))
          ],
        ),
      ),
    );
  }

  Color _colorChangePrice(int index, List<Crypto> cryptoList) {
    return cryptoList[index].changePercent24Hr > 0 ? greenColor : redColor;
  }

  Widget _changePercentTrend(int index, List<Crypto> cryptoList) {
    return cryptoList[index].changePercent24Hr > 0
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
}
