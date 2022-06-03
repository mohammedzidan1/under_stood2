part of 'regestration_cubit.dart';

@immutable
abstract class RegestrationState {}

//initial
class RegestrationInitial extends RegestrationState {}

// add record
class AddRecordLoadingState extends RegestrationState {}

class AddRecordSucssesState extends RegestrationState {}

class AddRecordErrorState extends RegestrationState {
  final String? onError;
  AddRecordErrorState({this.onError});
}

//patent states
class PatientLoginLoadingState extends RegestrationState {}

class PatientLoginSucssesState extends RegestrationState {}

class PatientLoginErrorState extends RegestrationState {
  final String? error;
  PatientLoginErrorState({this.error});
}

class PatientSigUpLoadingState extends RegestrationState {}

class PatientSigUpSucssesState extends RegestrationState {}

class PatientSigUpErrorState extends RegestrationState {
  final String? error;
  PatientSigUpErrorState({this.error});
}

class PatientCollectionSucssesState extends RegestrationState {}

class PatientCollectionLoadingState extends RegestrationState {}

class PatientCollectionErrorState extends RegestrationState {
  final String? error;
  PatientCollectionErrorState({this.error});
}

// doctor states
class DoctorLoginLoadingState extends RegestrationState {}

class DoctorLoginSucssesState extends RegestrationState {}

class DoctorLoginErrorState extends RegestrationState {
  final String? error;
  DoctorLoginErrorState({this.error});
}

class DoctorSignUpLoadingState extends RegestrationState {}

class DoctorSignUpSucssesState extends RegestrationState {}

class DoctorSignUpErrorState extends RegestrationState {
  final String? error;
  DoctorSignUpErrorState({this.error});
}

class DoctorCollectionSucssesState extends RegestrationState {}

class DoctortCollectionLoadingState extends RegestrationState {}

class DoctorCollectionErrorState extends RegestrationState {
  final String? error;
  DoctorCollectionErrorState({this.error});
}

class ChangePasswordVisibilityState extends RegestrationState {}
