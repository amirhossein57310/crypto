import 'package:crypto_application/data/model/crypto.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoState {}

class CryproResponseState extends CryptoState {
  Either<String, List<Crypto>> response;

  CryproResponseState(this.response);
}

class CryptoInitState extends CryptoState {}

class CryptoLoadingState extends CryptoState {}

class CryptoFilterState extends CryptoState {
  Either<String, List<Crypto>> response;
  String value;

  CryptoFilterState(this.response, this.value);
}
