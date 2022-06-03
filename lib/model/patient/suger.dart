import 'package:firestore_model/firestore_model.dart';

class SugerRate extends SubCollectionModel<SugerRate> {
  String? suger;
  SugerRate({this.suger});
  SugerRate.fromJson(Map<String, dynamic> json) {
    suger = json['suger'];
  }
  @override
  Map<String, dynamic> get toMap => {"suger": suger};

  @override
  ResponseBuilder<SugerRate> get responseBuilder =>
      (map) => SugerRate.fromJson(map);
}
