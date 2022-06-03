import 'package:firestore_model/firestore_model.dart';

class PatientUserModel extends FirestoreModel<PatientUserModel> {
  String? name;
  String? phone;

  String? email;

  String? uId;
  PatientUserModel({this.name, this.email, this.phone, this.uId});

  PatientUserModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];

    phone = map['phone'];

    uId = map['uId'];
  }
  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'email': email,
        'phone': phone,
        'uId': uId,
      };

  @override
  ResponseBuilder<PatientUserModel> get responseBuilder =>
      (map) => PatientUserModel.fromMap(map);
  @override
  String get collectionName => 'users';
}
