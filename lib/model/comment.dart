import 'package:firestore_model/firestore_model.dart';

class Comment extends SubCollectionModel<Comment> {
  String? doctorName;
  String? massage;

  Comment({this.doctorName, this.massage});

  Comment.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctorName'];
    massage = json['massage'];
  }

  @override
  Map<String, dynamic> get toMap => {
        "doctorName": doctorName,
        "massage": massage,
      };

  @override
  ResponseBuilder<Comment> get responseBuilder =>
      (map) => Comment.fromJson(map);
}
