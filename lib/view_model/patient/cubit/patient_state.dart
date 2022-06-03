part of 'patient_cubit.dart';

@immutable
abstract class PatientState {}

class PatientInitial extends PatientState {}
class PatientGetRecordLoadingState extends PatientState {}

class PatientGetRecordSucssesState extends PatientState {}

class PatientGetRecordErrorState extends PatientState {}

class PatientSugerLoadingState extends PatientState {}

class PatientSugerSucssesState extends PatientState {}

class PatientSugerErrorState extends PatientState {}