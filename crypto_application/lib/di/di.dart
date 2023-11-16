import 'package:crypto_application/data/datasource/crypto_datasource.dart';
import 'package:crypto_application/data/repository/crypto_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getItInIt() async {
  _initCompotents();
  _initDataSource();
  _initRepository();
}

void _initDataSource() {
  locator.registerSingleton<IcryptoDatasource>(
      CryptoRemoteDatasource(locator.get()));
}

void _initRepository() {
  locator.registerSingleton<IcryptoRepository>(
      CryptoRemoteRepository(locator.get()));
}

void _initCompotents() {
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'https://api.coincap.'),
    ),
  );
}
