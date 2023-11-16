import 'package:bloc/bloc.dart';
import 'package:crypto_application/data/bloc/crypto_event.dart';
import 'package:crypto_application/data/bloc/crypto_state.dart';
import 'package:crypto_application/data/repository/crypto_repository.dart';

class CryptoBloc extends Bloc<CryproEvent, CryptoState> {
  IcryptoRepository _repository;
  CryptoBloc(this._repository) : super(CryptoLoadingState()) {
    on<CryproResposneEvent>((event, emit) async {
      var response = await _repository.cryptoList();
      emit(CryproResponseState(response));
    });
    on<CryptoResponseFilterEvent>((event, emit) async {
      var response = await _repository.filterCryptoList(event.value);
      emit(CryptoFilterState(response, event.value));
    });
  }
}
