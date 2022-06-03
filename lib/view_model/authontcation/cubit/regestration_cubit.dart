import 'package:deaf_mute_clinic/helper/constant/constant.dart';
import 'package:deaf_mute_clinic/model/doctor/doctor_user_model.dart';
import 'package:deaf_mute_clinic/model/patient/patient_record_model.dart';
import 'package:deaf_mute_clinic/model/patient/patient_user_model.dart';
import 'package:deaf_mute_clinic/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/shared_prefrence/shared_prefrence.dart';

part 'regestration_state.dart';

class RegestrationCubit extends Cubit<RegestrationState> {
  RegestrationCubit() : super(RegestrationInitial());
  static RegestrationCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  var userModel;
  void getUserdata() async {
    User? user = FirebaseAuth.instance.currentUser;
    userModel = await FirestoreModel.use<PatientUserModel>().find(patientUId);
    emit(userModel);
  }

  //User uId=Abi.curren;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

// patient signup
  void patientSignUp({
    required String password,
    PatientUserModel? patientUserModel,
  }) {
    User? user = FirebaseAuth.instance.currentUser;
    emit(PatientSigUpLoadingState());

    AuthService()
        .register(patientUserModel?.email, password)
        .then((value) async {
      CacheHelper.putBoolean(key: 'patientUId', value: value.uid);
      patientUId=value.uid;
      await patientUserModel?.create(
          docId:FirebaseAuth.instance.currentUser?.uid);
        
      emit(PatientSigUpSucssesState());
    }).catchError((onError) {
      emit(PatientSigUpErrorState(error: onError.toString()));
    });
  }

  // add data to fire stoer for patient
  // void patientUserCollection({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String uId,
  // }) {
  //   PatientUserModel patientUserModel =
  //       PatientUserModel(name: name, phone: phone, email: email, uId: uId);
  //
  //   FirebaseFirestore.instance
  //       .collection('Patient')
  //       .doc(uId)
  //       .set(patientUserModel.toMap())
  //       .then((value) {
  //     emit(PatientCollectionSucssesState());
  //   }).catchError((onError) {
  //     emit(PatientCollectionErrorState(error: onError.toString()));
  //   });
  // }

// patient login
  void patientLogIn({required String email, required String password}) {
    emit(PatientLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
                patientUId=value.user!.uid;

      CacheHelper.putBoolean(key: 'patientUId', value: value.user!.uid);

      print(value.user!.email);
      emit(PatientLoginSucssesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(PatientLoginErrorState(error: onError.toString()));
    });
  }

  // doctor signup
  void doctorSignUp({
    DoctorUserModel? doctorUserModel,
    String? password,
  }) {
    emit(DoctorSignUpLoadingState());
   // User? user = FirebaseAuth.instance.currentUser;
    AuthService()
        .register(doctorUserModel?.email, password)
        .then((value) async {
          doctorUId=value.uid;
      CacheHelper.putBoolean(key: 'doctorUId', value: value.uid);
      await doctorUserModel?.create(
          docId:FirebaseAuth.instance.currentUser?.uid);

     // print(user?.uid);
      emit(DoctorSignUpSucssesState());
    }).catchError((onError) {
      emit(DoctorSignUpErrorState(error: onError.toString()));
    });
  }

  // doctor login
  void doctorLogIn({required String email, required String password}) {
    emit(DoctorLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
                    doctorUId=value.user!.uid;

      CacheHelper.putBoolean(key: 'doctorUId', value: value.user!.uid);

      emit(DoctorLoginSucssesState());
    }).catchError((onError) {
      emit(DoctorLoginErrorState(error: onError.toString()));
    });
  }

  // add data to fire stoer for doctor
  void doctorUserCollection({
    required String name,
    required String email,
    required String phone,
   // required String uId,
    required String addrees,
    required String speciality,
    required String degree,
    required String graduated,
  }) {
    DoctorUserModel doctorUserModel = DoctorUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: doctorUId,
      address: addrees,
      degree: degree,
      spetialicty: speciality,
      graguated: graduated,
    );
    // FirebaseFirestore.instance
    //     .collection('Doctor')
    //     .doc(uId)
    //     .set(doctorUserModel.toMap())
    //     .then((value) {
    //   emit(DoctorCollectionSucssesState());
    // }).catchError((onError) {
    //   emit(DoctorCollectionErrorState(error: onError.toString()));
    // });
  }

  void patientAddRecord({
    required String patientName,
    required String email,
    required String aatientAge,
    required String dOb,
    required String mobilePhone,
    required String homePhone,
    required String lifestage,
    required String preferredLocation,
    required String referredby,
    required String namePersonCompleting,
    required String address,
    required String reasonforappointment,
    required String currentSeeingTherapist,
    required String currentSeeingTherapistWho,
    required String currentSeeingTherapistHowLong,
    required String currentlyMedicationsAndDosage,
    required String previousPsychiatric,
    required String previousPsychiatricExplain,
    required String eatingDiorder,
    required String eatingDiorderHowLongAgo,
    required String suicidalleation,
    required String suicidalleationHowLongAgo,
    required String thoughtsOfHurmingOthers,
    required String thoughtsOfHurmingOthersExplain,
    required String sugarRate,
    required String obstruction,
    required String date,
  }) {
    PatientRecordModel patientRecordModel = PatientRecordModel(
        patientName: patientName,
        date: date,
        email: email,
        aatientAge: aatientAge,
        dOb: dOb,
        mobilePhone: mobilePhone,
        homePhone: homePhone,
        lifestage: lifestage,
        uId: patientUId,
        preferredLocation: preferredLocation,
        referredby: referredby,
        namePersonCompleting: namePersonCompleting,
        address: address,
        reasonforappointment: reasonforappointment,
        currentSeeingTherapist: currentSeeingTherapist,
        currentSeeingTherapistHowLong: currentSeeingTherapistHowLong,
        currentSeeingTherapistWho: currentSeeingTherapistWho,
        currentlyMedicationsAndDosage: currentlyMedicationsAndDosage,
        previousPsychiatric: previousPsychiatric,
        previousPsychiatricExplain: previousPsychiatricExplain,
        eatingDiorder: eatingDiorder,
        eatingDiorderHowLongAgo: eatingDiorderHowLongAgo,
        suicidalleation: suicidalleation,
        suicidalleationHowLongAgo: suicidalleationHowLongAgo,
        thoughtsOfHurmingOthers: thoughtsOfHurmingOthers,
        thoughtsOfHurmingOthersExplain: thoughtsOfHurmingOthersExplain,
        sugarRate: sugarRate,
        obstruction: obstruction);
    emit(AddRecordLoadingState());
    // FirebaseFirestore.instance
    //     .collection('Patient')
    //     .doc(patientUId)
    //     .set(
    //       patientRecordModel.toMap(),
    //       //  optionalTypeArgs
    //     )
    //     .then((value) {
    //   emit(AddRecordSucssesState());
    // }).catchError((onError) {
    //   emit(AddRecordErrorState(onError: onError.toString()));
    // });
  }
}
