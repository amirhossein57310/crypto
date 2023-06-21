class User {
  int id;
  String name;
  String username;

  User(this.id, this.name, this.username);

  factory User.fromMapJson(Map<String, dynamic> jsonObject) {
    return User(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['username'],
    );
  }
}
