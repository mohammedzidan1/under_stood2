import 'package:deaf_mute_clinic/helper/constant/constant.dart';
import 'package:deaf_mute_clinic/model/doctor/doctor_user_model.dart';
import 'package:deaf_mute_clinic/view_model/authontcation/cubit/regestration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/notifications.dart';
import '../../../helper/routs/routs_name.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_form_feild.dart';

class SignUpScreenForDoctor extends StatefulWidget {
  final int? signNumer;

  const SignUpScreenForDoctor({Key? key, this.signNumer}) : super(key: key);

  @override
  State<SignUpScreenForDoctor> createState() => _SignUpScreenForDoctorState();
}

class _SignUpScreenForDoctorState extends State<SignUpScreenForDoctor> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addreesController = TextEditingController();
  var degreeController = TextEditingController();
  var speialictyController = TextEditingController();
  var graduatedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = RegestrationCubit.get(context);
    return BlocConsumer<RegestrationCubit, RegestrationState>(
      listener: (context, state) {
        if (state is DoctorSignUpErrorState) {
          final snackBar = SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.red,
            content: Text(state.error.toString()),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DoctorCollectionSucssesState) {
          Navigator.pushReplacementNamed(context, RoutsNames.doctorHome);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          body: Container(
            margin: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                key: formKey,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 12, right: 10),
                      child: CustomText(
                        text: "Let's care about our health",
                        color: Color(
                          0xff292929,
                        ),
                        fontSise: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: nameController,
                              lableText: "Name",
                              keyBordType: TextInputType.name,
                              validation: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              prefexIcon: Icons.person),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            controller: emailController,
                            lableText: "Email",
                            keyBordType: TextInputType.emailAddress,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            prefexIcon: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            isPassward: cubit.isPassword,
                            suffixOnTap: () {
                              cubit.changePasswordVisibility();
                            },
                            controller: passwordController,
                            lableText: "Create password",
                            prefexIcon: Icons.lock_outlined,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            sufixIcon: cubit.suffix,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            lableText: "Phone",
                            keyBordType: TextInputType.phone,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            prefexIcon: Icons.phone_android_outlined,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            keyBordType: TextInputType.name,
                            controller: addreesController,
                            lableText: "Address",
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            // prefexIcon: Icons.addres,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            controller: speialictyController,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            lableText: "Speciality",
                            keyBordType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            controller: degreeController,
                            lableText: "Degree",
                            keyBordType: TextInputType.name,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextField(
                            controller: graduatedController,
                            lableText: "Graduated",
                            keyBordType: TextInputType.name,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  state is DoctorSignUpLoadingState
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: "Sign Up",
                          ontap: () {
                            validationInput(cubit);
                          },
                          height: 50,
                          width: 260,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void validationInput(cubit) {
    if (emailController.text.isEmpty ||
        !emailController.text.contains('doctor') ||
        !emailController.text.contains('@')) {
      Notifications.error('You must enter correct email and contains doctor');
    } else if (passwordController.text.isEmpty) {
      Notifications.error('you must enter correct password');
    } else if (nameController.text.isEmpty) {
      Notifications.error('you must enter correct name');
    } else {
      DoctorUserModel doctorUserModel = DoctorUserModel(
        name: nameController.text,
        phone: phoneController.text,
        spetialicty: speialictyController.text,
        degree: degreeController.text,
        graguated: graduatedController.text,
        address: addreesController.text,
        email: emailController.text,
       // uId: doctorUId
      );
      cubit.doctorSignUp(
          doctorUserModel: doctorUserModel, password: passwordController.text);
      Navigator.pushReplacementNamed(context, RoutsNames.doctorHome);
    }
  }
}
