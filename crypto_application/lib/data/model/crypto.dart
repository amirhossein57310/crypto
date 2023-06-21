class Crypto {
  String name;
  String id;
  int rank;
  String symbol;
  double marketCapUsd;
  double volumeUsd24Hr;
  double priceUsd;
  double changePercent24Hr;

  Crypto(this.name, this.id, this.rank, this.symbol, this.marketCapUsd,
      this.volumeUsd24Hr, this.priceUsd, this.changePercent24Hr);

  factory Crypto.fromJsonObject(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      jsonMapObject['name'],
      jsonMapObject['id'],
      int.parse(jsonMapObject['rank']),
      jsonMapObject['symbol'],
      double.parse(jsonMapObject['marketCapUsd']),
      double.parse(jsonMapObject['volumeUsd24Hr']),
      double.parse(jsonMapObject['priceUsd']),
      double.parse(jsonMapObject['changePercent24Hr']),
    );
  }
}
