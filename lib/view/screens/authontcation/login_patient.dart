import 'package:deaf_mute_clinic/helper/notifications.dart';
import 'package:deaf_mute_clinic/view_model/authontcation/cubit/regestration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/routs/routs_name.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_form_feild.dart';

// ignore: must_be_immutable
class LogInScreenforPatient extends StatelessWidget {
  LogInScreenforPatient({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  // var controllar = TextEditingController();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = RegestrationCubit.get(context);

    return BlocConsumer<RegestrationCubit, RegestrationState>(
      listener: (context, state) {
        if (state is PatientLoginErrorState) {
          final snackBar = SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.red,
            content: Text(state.error.toString()),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is PatientLoginSucssesState) {
          Navigator.pushNamed(context, RoutsNames.patientHome);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color.fromARGB(255, 253, 250, 250),
          body: Container(
            margin: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
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
                      lableText: "Email",
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
                      lableText: "Passward",
                      prefexIcon: Icons.lock_outlined,
                      sufixIcon: cubit.suffix,
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    state is PatientLoginLoadingState
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: "Log In",
                            ontap: () {
                              validationInput(cubit);
                            },
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
          ),
        );
      },
    );
  }

  void validationInput(cubit) {
    if (emailController.text.isEmpty ||
        emailController.text.contains('doctor') ||
        !emailController.text.contains('@')) {
      Notifications.error('You must enter correct email and contains doctor');
    } else if (passwordController.text.isEmpty) {
      Notifications.error('you must enter correct password');
    } else {
      cubit.patientLogIn(
          email: emailController.text, password: passwordController.text);
    }
  }
}
