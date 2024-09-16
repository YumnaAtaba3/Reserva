import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/email_verfication/cubit/email_verification_cubit.dart';
import 'package:reserva/cubits/shared/auth/email_verfication/cubit/email_verification_state.dart';
import 'package:reserva/pages/admin/admin_drawer.dart';
import 'package:reserva/pages/company_owner/hotel/hotel_drawer.dart';
import 'package:reserva/pages/shared/forget_password2.dart';

import 'package:reserva/widgets/shared/video_player.dart';

class ForgetPasswordPage1 extends StatelessWidget {
  ForgetPasswordPage1({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();

  final FocusNode _focusNodePassword = FocusNode();

  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EmailVerificationCubit cubit =
        BlocProvider.of<EmailVerificationCubit>(context);

    return BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state is EmailVerificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(state.message.toString()),
            ),
          );
          /* showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text('Verified successfully'),
                  )));*/

          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return ForgetPasswordPage2();
            },
          ));
        } else if (state is EmailVerificationFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
          _formKey.currentState?.reset();
        } else if (state is EmailVerificationValidationFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.errors.toString()),
                  )));
        }
      },
      builder: (context, state) {
        return state is EmailVerificationLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                            height: 800,
                            child: AspectRatio(
                                aspectRatio: 16 / 9, child: VideoPlayerWidget())
                            //Image.asset("images/login_screen_image.png"),
                            )),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/logo4.png",
                                          height: 200,
                                          width: 250,
                                          // height: 200,
                                          //width: 200,
                                        ),
                                        /*Image.asset(
                                    "images/d.jpg",
                                    // height: 200,
                                    //width: 200,
                                  ),
                                  SizedBox(
                                    width: 0,
                                  ),
                                  Text("Reserva",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff085373),
                                          fontSize: 70,
                                          fontFamily: "DancingScript")),*/
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Enter your email :",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.5,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            cursorColor: Colors.blue,
                                            controller: _controllerEmail,
                                            focusNode: _focusNodeEmail,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              focusColor: Colors.blue,
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2)),
                                              labelStyle:
                                                  TextStyle(color: Colors.blue),
                                              labelText: "Email",
                                              prefixIcon: const Icon(
                                                  Icons.email_outlined,
                                                  color: Colors.blue),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff085373),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Please enter email.";
                                              } else if (value !=
                                                  prefs!.getString('email')) {
                                                state is EmailVerificationValidationFailure &&
                                                        state.errors
                                                            .containsKey(
                                                                "email")
                                                    ? Text(
                                                        state.errors["email"]![
                                                            0],
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Text("");
                                              } else {
                                                return null;
                                              }
                                            },
                                            onEditingComplete: () =>
                                                _focusNodePassword
                                                    .requestFocus(),
                                          ),
                                          state is EmailVerificationValidationFailure &&
                                                  state.errors
                                                      .containsKey("email")
                                              ? Text(
                                                  state.errors["email"]![0],
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Text("")
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.3,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff085373),
                                          minimumSize:
                                              const Size.fromHeight(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.email_verification(
                                            email: _controllerEmail.text,
                                          );
                                          // if (_formKey.currentState?.validate() ??
                                          //     false) {

                                          //   _formKey.currentState?.reset();
                                          //   Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) {
                                          //         return ForgetPasswordPage2();
                                          //       },
                                          //     ),
                                          //   );
                                          // }
                                        },
                                        child: const Text(
                                          "Search",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ]),
                            )),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
