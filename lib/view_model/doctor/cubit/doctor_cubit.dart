import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deaf_mute_clinic/model/patient/patient_record_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/doctor/doctor_user_model.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorUserModel? doctorUserModel;
  DoctorCubit() : super(DoctorInitial());
  static DoctorCubit get(context) => BlocProvider.of(context);
  void doctorGetData() {
    emit(DoctorUserGetDataLoadingState());

    /* FirebaseFirestore.instance
        .collection('Doctor')
        .doc(doctorUId)
        .get()
        .then((value) {
      doctorUserModel = DoctorUserModel.fromJson(value.data()!);
      emit(DoctorUserGetDataSucssesState());
    }).catchError((onError) {
      emit(DoctorUserGetDataErrorState());
    });*/
  }

  List<PatientRecordModel> patientRecordModel = [];
  void getAllRecords() {
    emit(GetAllRecordsDataLoadingState());

    FirebaseFirestore.instance.collection('Patient').get().then((value) {
      value.docs.forEach((element) {
        // patientRecordModel.add(PatientRecordModel.fromJson(element.data()));
      });
      emit(GetAllRecordsDataSucssesState());
    }).catchError((onError) {});
  }
}
