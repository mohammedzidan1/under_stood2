import 'package:asuka/asuka.dart' as asuka;
import 'package:deaf_mute_clinic/helper/routs/app_routs.dart';
import 'package:deaf_mute_clinic/model/comment.dart';
import 'package:deaf_mute_clinic/model/doctor/doctor_user_model.dart';
import 'package:deaf_mute_clinic/model/patient/patient_record_model.dart';
import 'package:deaf_mute_clinic/model/patient/patient_user_model.dart';
import 'package:deaf_mute_clinic/model/patient/suger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';

import 'helper/constant/constant.dart';
import 'helper/shared_prefrence/shared_prefrence.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreModel.injectAll([
    DoctorUserModel(),
    PatientUserModel(),
    PatientRecordModel(),
    SugerRate(),
    Comment(),
  ]);
  await CacheHelper.init();
  CacheHelper.getData(key: 'patientUId') != null
      ? patientUId = CacheHelper.getData(key: 'patientUId')
      : patientUId = "";
  CacheHelper.getData(key: 'doctorUId') != null
      ? doctorUId = CacheHelper.getData(key: 'doctorUId')
      : doctorUId = "";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouts().genirateRoute,
    );
  }
}
