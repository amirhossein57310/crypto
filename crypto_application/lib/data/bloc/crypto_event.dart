abstract class CryproEvent {}

class CryproResposneEvent extends CryproEvent {
  CryproResposneEvent();
}

class CryptoResponseFilterEvent extends CryproEvent {
  String value;
  CryptoResponseFilterEvent(this.value);
}
