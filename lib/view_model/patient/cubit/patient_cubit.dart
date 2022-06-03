import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deaf_mute_clinic/helper/constant/constant.dart';
import 'package:deaf_mute_clinic/model/patient/patient_record_model.dart';
import 'package:deaf_mute_clinic/model/patient/patient_user_model.dart';
import 'package:deaf_mute_clinic/model/patient/suger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientRecordModel? patientRecordModel;
  PatientCubit() : super(PatientInitial());
  static PatientCubit get(context) => BlocProvider.of(context);
  void patientGetRecord() {
    emit(PatientGetRecordLoadingState());

    FirebaseFirestore.instance
        .collection('Patient')
        .doc(patientUId)
        .get()
        .then((value) {
      // patientRecordModel = PatientRecordModel.fromJson(value.data()!);
      emit(PatientGetRecordSucssesState());
    }).catchError((onError) {
      emit(PatientGetRecordErrorState());
    });
  }

  void patientAddSugarRate({required String suger}) async {
    User? user = FirebaseAuth.instance.currentUser;
    PatientUserModel? userModel =
        await FirestoreModel.use<PatientUserModel>().find(user!.uid);
    SugerRate? sugerRate = userModel?.subCollection<SugerRate>();
    sugerRate?.suger = suger;
    await sugerRate?.create();
  }
}
