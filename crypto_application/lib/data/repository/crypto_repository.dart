import 'package:crypto_application/data/datasource/crypto_datasource.dart';
import 'package:crypto_application/data/model/crypto.dart';
import 'package:crypto_application/util/api_error.dart';
import 'package:dartz/dartz.dart';

abstract class IcryptoRepository {
  Future<Either<String, List<Crypto>>> cryptoList();
  Future<Either<String, List<Crypto>>> filterCryptoList(String value);
}

class CryptoRemoteRepository extends IcryptoRepository {
  final IcryptoDatasource _datasource;
  CryptoRemoteRepository(this._datasource);
  @override
  Future<Either<String, List<Crypto>>> cryptoList() async {
    try {
      var response = await _datasource.cryptoList();
      return right(response);
    } on ApiError catch (ex) {
      return left(ex.message ?? 'خطایی به وجود آمده است');
    }
  }

  @override
  Future<Either<String, List<Crypto>>> filterCryptoList(String value) async {
    try {
      var response = await _datasource.filterCryptoList(value);
      return right(response);
    } on ApiError catch (ex) {
      return left(ex.message ?? 'خطایی به وجود آمده است');
    }
  }
}
