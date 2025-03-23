class UserModel {
  String? uid;
  String? email;

  UserModel({this.uid, this.email});

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
    );
  }
}
