import 'package:deaf_mute_clinic/helper/theme/theme.dart';
import 'package:deaf_mute_clinic/model/patient/patient_record_model.dart';
import 'package:deaf_mute_clinic/model/patient/suger.dart';
import 'package:deaf_mute_clinic/view/widget/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';

import '../../../model/comment.dart';
import '../../../model/patient/patient_user_model.dart';

class PatientReportScreen extends StatelessWidget {
  const PatientReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModelStreamSingleBuilder<PatientRecordModel>(
        docId: FirebaseAuth.instance.currentUser?.uid,
        // query: (q) =>
        //     q.where('uId', isEqualTo: FirebaseAuth.instance.currentUser?.uid),
        onEmpty: () => const Center(
              child: CustomText(
                text: 'No record yet',
              ),
            ),
        onLoading: () => const Center(child: CircularProgressIndicator()),
        onSuccess: (record) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsApp.appBarColor,
              title: const CustomText(
                text: "Your Report",
                fontSise: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: bildreportWidget(context, record),
          );
        });
  }
}

PatientUserModel? userModel;

getUser() async {
  User? user = FirebaseAuth.instance.currentUser;
  userModel = await FirestoreModel.use<PatientUserModel>().find(user!.uid);
}

bildreportWidget(context, PatientRecordModel? patientRecordModel) {
  getUser();
  print('user ${userModel?.toMap}');
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ModelStreamGetBuilder<Comment>(
            parentModel: userModel,
            onLoading: () => const Center(child: CircularProgressIndicator()),
            onEmpty: () => const CustomText(
                  text: 'No comment yet',
                ),
            onError: (e) => Center(
                  child: CustomText(
                    text: e.toString(),
                  ),
                ),
            onSuccess: (comments) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments?.length,
                  itemBuilder: (context, index) {
                    Comment? comment = comments![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text:
                            'Doctor ${comment?.doctorName} your comment in your report ${comment?.massage}',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSise: 20,
                      ),
                    );
                  });
            }),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 239, 239).withOpacity(.9),
              borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContanerItem(
                  context,
                  "Patient Name : ${patientRecordModel!.patientName}",
                ),
                buildContanerItem(
                  context,
                  "Your obstraction  : ${patientRecordModel.obstruction}",
                ),
                Container(
                  height: 200,
                  child: ModelStreamGetBuilder<SugerRate>(
                      parentModel: userModel,
                      onSuccess: (rates) {
                        return ListView.builder(
                            itemCount: rates?.length,
                            itemBuilder: (context, index) {
                              SugerRate? rate = rates![index];
                              return Column(
                                children: [
                                  if (index == 0)
                                    buildContanerItem(
                                      context,
                                      "Initial Rate :${patientRecordModel.sugarRate} ",
                                    ),
                                  CustomText(
                                    text:
                                        'This rate create at ${rate?.createdAt}',
                                    fontSise: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                  buildContanerItem(
                                    context,
                                    " Rate  :${rate?.suger} ",
                                  ),
                                ],
                              );
                            });
                      }),
                ),
                buildContanerItem(
                  context,
                  "Email  : ${patientRecordModel.email}",
                ),
                buildContanerItem(
                  context,
                  "Patient Age :${patientRecordModel.aatientAge} ",
                ),
                buildContanerItem(
                  context,
                  "DOB : ${patientRecordModel.dOb}",
                ),
                buildContanerItem(
                    context, "Mobile Phone : ${patientRecordModel.mobilePhone}"
                    // report.pills ?? '',
                    ),
                buildContanerItem(
                  context,
                  "Home Phone :${patientRecordModel.homePhone}",
                ),
                buildContanerItem(
                  context,
                  //   report!.date,
                  "life stage : ${patientRecordModel.lifestage}",
                ),
                buildContanerItem(
                  context,
                  "Preferred Location : ${patientRecordModel.preferredLocation}",
                ),
                buildContanerItem(
                  context,
                  "Referred by :${patientRecordModel.referredby}",
                ),
                buildContanerItem(
                  context,
                  "Name Person Completing : ${patientRecordModel.namePersonCompleting}",
                ),
                buildContanerItem(
                  context,
                  "Address :${patientRecordModel.address}",
                ),
                buildContanerItem(
                  context,
                  "Reason for appointment :${patientRecordModel.reasonforappointment}",
                ),
                buildContanerItem(
                  context,
                  "Current seeing a Therapist  : ${patientRecordModel.currentSeeingTherapist} ",
                ),
                buildContanerItem(
                  context,
                  "Who  :${patientRecordModel.currentSeeingTherapistWho}",
                ),
                buildContanerItem(
                  context,
                  "How long  :${patientRecordModel.currentSeeingTherapistHowLong}",
                ),
                buildContanerItem(
                  context,
                  "Currently medications and dosage  :${patientRecordModel.currentlyMedicationsAndDosage}",
                ),
                buildContanerItem(
                  context,
                  "Previous Psychiatric :${patientRecordModel.previousPsychiatric}",
                ),
                buildContanerItem(
                  context,
                  "Explain :${patientRecordModel.previousPsychiatricExplain}",
                ),
                buildContanerItem(
                  context,
                  "Eating Diorder  :${patientRecordModel.eatingDiorder}",
                ),
                buildContanerItem(
                  context,
                  "How long ago :${patientRecordModel.eatingDiorderHowLongAgo}",
                ),
                buildContanerItem(
                  context,
                  "Suicidal leation  :${patientRecordModel.suicidalleation}",
                ),
                buildContanerItem(
                  context,
                  "How long ago :${patientRecordModel.suicidalleationHowLongAgo}",
                ),
                buildContanerItem(
                  context,
                  "Thoughts of hurming others :${patientRecordModel.thoughtsOfHurmingOthers}",
                ),
                buildContanerItem(
                  context,
                  "Explain :${patientRecordModel.thoughtsOfHurmingOthersExplain}",
                ),
                buildContanerItem(
                  context,
                  "Challenge :${patientRecordModel.challenge}",
                ),
                buildContanerItem(
                  context,
                  "Physical :${patientRecordModel.physical}",
                ),
                buildContanerItem(
                  context,
                  "whyPhysical :${patientRecordModel.whyPhysical}",
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildContanerItem(context, text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        text: text,
        color: Colors.black,
        fontSise: 18,
        fontWeight: FontWeight.bold,
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        width: MediaQuery.of(context).size.width * .7,
        height: 1,
        color: ColorsApp.primaryColor,
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}
