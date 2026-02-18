class UserModel {
  late String _uid;
  late String _name;
  late String _email;

  String get uid => _uid;
  String get nome => _name;
  String get email => _email;

  UserModel({
    required String uid,
    required String name,
    required String email,
  }) {
    _uid = uid;
    _name = name;
    _email = email;
  }

  @override
  String toString() {
    return 'UserModel(uid: $_uid, name: $_name, email: $_email)';
  }
}
