import 'package:deaf_mute_clinic/helper/notifications.dart';
import 'package:deaf_mute_clinic/helper/routs/routs_name.dart';
import 'package:deaf_mute_clinic/view_model/authontcation/cubit/regestration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_form_feild.dart';

class LogInScreenforDoctor extends StatefulWidget {
  const LogInScreenforDoctor({Key? key}) : super(key: key);

  @override
  State<LogInScreenforDoctor> createState() => _LogInScreenforDoctorState();
}

class _LogInScreenforDoctorState extends State<LogInScreenforDoctor> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = RegestrationCubit.get(context);

    return BlocConsumer<RegestrationCubit, RegestrationState>(
      listener: (context, state) {
        if (state is DoctorLoginErrorState) {
          final snackBar = SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.red,
            content: Text(state.error.toString()),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DoctorLoginSucssesState) {
          Navigator.pushNamed(context, RoutsNames.doctorHome);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          // backgroundColor: const Color.fromARGB(255, 227, 226, 226),
          body: Container(
            margin: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                key: formKey,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12, right: 105),
                    child: CustomText(
                      text: "Login in your account",
                      color: Colors.black,
                      fontSise: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    controller: emailController,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return 'password is too short';
                      }
                    },
                    lableText: "Email",
                    prefexIcon: Icons.email_outlined,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    isPassward: cubit.isPassword,
                    controller: passwordController,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return 'password is too short';
                      }
                    },
                    lableText: "Passward",
                    prefexIcon: Icons.lock_outlined,
                    sufixIcon: cubit.suffix,
                    suffixOnTap: () {
                      cubit.changePasswordVisibility();
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  state is DoctorLoginLoadingState
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: "Log In",
                          ontap: () {
                            //  if (formKey.currentState!.validate()) {
                            validationInput(cubit);
                          }
                          //   },
                          ,
                          height: 50,
                          width: 260,
                        ),
                  const SizedBox(
                    height: 18.0,
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
    } else {
      cubit.doctorLogIn(
          email: emailController.text, password: passwordController.text);
    }
  }
}
