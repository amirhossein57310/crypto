import 'package:crypto_application/data/model/crypto.dart';
import 'package:crypto_application/util/api_error.dart';
import 'package:dio/dio.dart';

abstract class IcryptoDatasource {
  Future<List<Crypto>> cryptoList();
  Future<List<Crypto>> filterCryptoList(String value);
}

class CryptoRemoteDatasource extends IcryptoDatasource {
  final Dio _dio;
  CryptoRemoteDatasource(this._dio);
  @override
  Future<List<Crypto>> cryptoList() async {
    try {
      var response = await _dio.get('io/v2/assets');

      List<Crypto> cryptoList = response.data['data']
          .map<Crypto>((jsonObject) => Crypto.fromJsonObject(jsonObject))
          .toList();
      return cryptoList;
    } on DioError catch (ex) {
      throw (
        ApiError(
          ex.response!.statusCode,
          ex.response!.data['message'],
        ),
      );
    }
  }

  @override
  Future<List<Crypto>> filterCryptoList(String value) async {
    var response = await _dio.get('io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonObject) => Crypto.fromJsonObject(jsonObject))
        .toList();

    return cryptoList.where((element) {
      return element.name.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }
}
