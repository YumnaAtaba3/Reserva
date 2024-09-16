import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/check_code/cubit/check_code_cubit.dart';
import 'package:reserva/cubits/shared/auth/check_code/cubit/check_code_state.dart';
import 'package:reserva/pages/shared/forget_password3.dart';

import 'package:reserva/widgets/shared/video_player.dart';

class ForgetPasswordPage2 extends StatelessWidget {
  ForgetPasswordPage2({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _controllerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CheckCodeCubit cubit = BlocProvider.of<CheckCodeCubit>(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return BlocConsumer<CheckCodeCubit, CheckCodeState>(
      listener: (context, state) {
        if (state is CheckCodeSuccess) {
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
              return ForgetPasswordPage3();
            },
          ));
        } else if (state is CheckCodeResend) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text("Resend Successfully"),
            ),
          );

          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return ForgetPasswordPage2();
            },
          ));
        } else if (state is CheckCodeFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
          formKey.currentState?.reset();
        } else if (state is CheckCodeValidationFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.errors.toString()),
                  )));
        }
      },
      builder: (context, state) {
        return state is CheckCodeLoading
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
                            key: formKey,
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
                                        /*  Image.asset(
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
                                      "We sent your code to : ${prefs!.getString('email')}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Please check your email for a text message with your code.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700],
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      " Your code is 6 characters long.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700],
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Enter the 6-digit code :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.4,
                                      child: Column(
                                        children: [
                                          Pinput(
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Please enter code";
                                              } else if (value !=
                                                  prefs!.getString('data')) {
                                                state is CheckCodeValidationFailure &&
                                                        state.errors
                                                            .containsKey("code")
                                                    ? Text(
                                                        state
                                                            .errors["code"]![0],
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Text("");
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: _controllerCode,
                                            length: 6,
                                            defaultPinTheme: defaultPinTheme,
                                            focusedPinTheme:
                                                defaultPinTheme.copyWith(
                                              decoration: defaultPinTheme
                                                  .decoration!
                                                  .copyWith(
                                                border: Border.all(
                                                    color: Color(0xff085373)),
                                              ),
                                            ),
                                            onCompleted: (pin) =>
                                                debugPrint(pin),
                                          ),
                                          state is CheckCodeValidationFailure &&
                                                  state.errors
                                                      .containsKey("code")
                                              ? Text(
                                                  state.errors["code"]![0],
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Text("")
                                        ],
                                      ),

                                      /* TextFormField(
                              cursorColor: Colors.blue,
                              controller: _controllerPassword,
                              //obscureText: _obscurePassword,
                              focusNode: _focusNodePassword,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    6), // Limit input to 6 characters
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusColor: Colors.blue,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 2)),
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Code",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff085373), width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Code.";
                                } else if (value.length != 6) {
                                  return "Code must be  6 character.";
                                }
                                return null;
                              },
                              onEditingComplete: () =>
                                  _focusNodeConfirmPassword.requestFocus(),
                            ),*/
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                        width: 300,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff085373),
                                                  minimumSize:
                                                      const Size.fromHeight(50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      width: 200,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      content: const Text(
                                                          "Resend Successfully"),
                                                    ),
                                                  );

                                                  // _formKey.currentState
                                                  //     ?.reset();
                                                  // Navigator.pushReplacement(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) {
                                                  //       return ForgetPasswordPage2();
                                                  //     },
                                                  //   ),
                                                  // );

                                                  cubit.email_verification(
                                                      email: prefs!
                                                          .getString('email')
                                                          .toString());
                                                  //     if (_formKey.currentState
                                                  //             ?.validate() ??
                                                  //         false) {
                                                  //       /* _boxAccounts.put(
                                                  //   _controllerUsername.text,
                                                  //   _controllerConFirmPassword.text,
                                                  // );*/
                                                },
                                                child: const Text(
                                                  "Resend",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff085373),
                                                  minimumSize:
                                                      const Size.fromHeight(50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  cubit.check_code(
                                                    code: _controllerCode.text,
                                                  );
                                                  //     if (_formKey.currentState
                                                  //             ?.validate() ??
                                                  //         false) {
                                                  //       /* _boxAccounts.put(
                                                  //   _controllerUsername.text,
                                                  //   _controllerConFirmPassword.text,
                                                  // );*/

                                                  //       ScaffoldMessenger.of(context)
                                                  //           .showSnackBar(
                                                  //         SnackBar(
                                                  //           width: 200,
                                                  //           backgroundColor:
                                                  //               Theme.of(context)
                                                  //                   .colorScheme
                                                  //                   .secondary,
                                                  //           shape: RoundedRectangleBorder(
                                                  //             borderRadius:
                                                  //                 BorderRadius.circular(
                                                  //                     10),
                                                  //           ),
                                                  //           behavior:
                                                  //               SnackBarBehavior.floating,
                                                  //           content: const Text(
                                                  //               "Confirmed Successfully"),
                                                  //         ),
                                                  //       );

                                                  //       _formKey.currentState?.reset();
                                                  //       Navigator.pushReplacement(
                                                  //         context,
                                                  //         MaterialPageRoute(
                                                  //           builder: (context) {
                                                  //             return ForgetPasswordPage3();
                                                  //           },
                                                  //         ),
                                                  //       );
                                                  //     }
                                                },
                                                child: const Text(
                                                  "Continue",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
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
