part of 'doctor_cubit.dart';

@immutable
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}
class DoctorUserGetDataSucssesState extends DoctorState {}

class DoctorUserGetDataLoadingState extends DoctorState {}
class DoctorUserGetDataErrorState extends DoctorState {}
class GetAllRecordsDataErrorState extends DoctorState {}
class GetAllRecordsDataSucssesState extends DoctorState {}
class GetAllRecordsDataLoadingState extends DoctorState {}

