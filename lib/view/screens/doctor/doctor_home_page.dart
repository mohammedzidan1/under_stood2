import 'package:deaf_mute_clinic/helper/constant/constant.dart';
import 'package:deaf_mute_clinic/helper/notifications.dart';
import 'package:deaf_mute_clinic/helper/theme/theme.dart';
import 'package:deaf_mute_clinic/model/doctor/doctor_user_model.dart';
import 'package:deaf_mute_clinic/view/widget/custom_curve.dart';
import 'package:deaf_mute_clinic/view/widget/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';

import '../../../helper/routs/routs_name.dart';
import '../../widget/custom_button.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   DoctorCubit.get(context).doctorGetData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorsApp.appBarColor,
          actions: [
            IconButton(
                onPressed: () {
                  Notifications.dialog(
                    context,
                    child: AlertDialog(
                        backgroundColor: ColorsApp.appBarColor,
                        title: const Center(
                            child: Text(
                          "Are your sure to log out ?",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )),
                        actions: [
                          TextButton(
                              onPressed: () {
                                patientSignOut(context);
                              },
                              child: const CustomText(
                                text: "Ok",
                                fontWeight: FontWeight.bold,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const CustomText(
                                text: "Cancel",
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                            topRight: Radius.circular(130),
                          ),
                        )),
                  );
                },
                icon: const Icon(Icons.logout_outlined)),
          ]),
      body: Stack(
        children: [
          Background(),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),

                Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage:
                          AssetImage("assets/images/unknown-person.jpg"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ModelStreamSingleBuilder<DoctorUserModel>(
                      docId: FirebaseAuth.instance.currentUser?.uid,

                      onLoading: () => const CircularProgressIndicator(),
                      onSuccess: (doctor) => CustomText(
                        text: "Hello Dr ${doctor?.name}",
                        // text: "Hello, My Dear Mariam ",
                        color: ColorsApp.black,
                        fontSise: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  ontap: () {
                    showModalBottomSheet(
                        barrierColor: ColorsApp.primaryColor.withOpacity(.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        context: context,
                        builder: (context) => Container(
                              height: 240,
                              child: Column(
                                children: const [
                                  ListTile(
                                    leading: CustomText(
                                      text: " Monday at : ",
                                      color: ColorsApp.black,
                                      fontSise: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    title: CustomText(
                                        text: "8.00  Pm",
                                        color: ColorsApp.black),
                                    trailing: CustomText(
                                      text: " Mariam Tareq",
                                      fontSise: 17,
                                      fontWeight: FontWeight.w700,
                                      color: ColorsApp.appBarColor,
                                    ),
                                  ),
                                  ListTile(
                                    leading: CustomText(
                                      text: " Friday at : ",
                                      color: ColorsApp.black,
                                      fontSise: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    title: CustomText(
                                        text: "10.00  Am",
                                        color: ColorsApp.black),
                                    trailing: CustomText(
                                      text: " Ahmed Aly",
                                      fontSise: 17,
                                      fontWeight: FontWeight.w700,
                                      color: ColorsApp.appBarColor,
                                    ),
                                  ),
                                  ListTile(
                                    leading: CustomText(
                                      text: " Saturday at : ",
                                      color: ColorsApp.black,
                                      fontSise: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    title: CustomText(
                                        text: "12.00  Am",
                                        color: ColorsApp.black),
                                    trailing: CustomText(
                                      text: " Mohamed Zydan",
                                      fontSise: 17,
                                      fontWeight: FontWeight.w700,
                                      color: ColorsApp.appBarColor,
                                    ),
                                  )
                                ],
                              ),
                            ));
                  },
                  text: "Your Time Table",
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: "Your Record",
                  ontap: () {
                    Navigator.pushNamed(
                      context,
                      RoutsNames.doctorReport,
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                // CustomButton(
                //   text: "Your Patients",
                //   ontap: () {
                //     // Navigator.pushNamed(context, RoutsNames.registration,
                //     //     arguments: "doctor");
                //   },
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
