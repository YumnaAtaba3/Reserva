import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:reserva/cubits/shared/auth/reset_password/cubit/reset_password_state.dart';
import 'package:reserva/pages/admin/admin_drawer.dart';
import 'package:reserva/pages/company_owner/flights/flight_drawer.dart';
import 'package:reserva/pages/company_owner/hotel/hotel_drawer.dart';

import 'package:reserva/pages/shared/login.dart';
import 'package:reserva/widgets/shared/video_player.dart';

class ForgetPasswordPage3 extends StatelessWidget {
  ForgetPasswordPage3({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = BlocProvider.of<ResetPasswordCubit>(context);

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          if (state.role == 1) {
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(state.message.toString()),
            );

            /*showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      content: Text(state.message.toString()),
                    )));*/

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return HotelDrawer();
              },
            ));
          } else if (state.role == 2) {
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(state.message.toString()),
            );

            /*showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      content: Text(state.message.toString()),
                    )));*/

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return FlightDrawer();
              },
            ));
          } else if (state.role == 3) {
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(state.message.toString()),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AdminDrawer();
                },
              ),
            );
          } else {
            showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      content: Text(
                          'you have no permission to enter this dashboard'),
                    )));
          }
        } else if (state is ResetPasswordFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
          _formKey.currentState?.reset();
        } else if (state is ResetPasswordValidationFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.errors.toString()),
                  )));
        }
      },
      builder: (context, state) {
        return state is ResetPasswordLoading
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
                                      "Create a new password :",
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
                                      widthFactor: 0.4,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            cursorColor: Colors.blue,
                                            controller: _controllerPassword,
                                            obscureText: cubit.is_scure1,
                                            focusNode: _focusNodePassword,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              focusColor: Colors.blue,
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2)),
                                              labelStyle:
                                                  TextStyle(color: Colors.blue),
                                              labelText: "Password",
                                              prefixIcon: const Icon(
                                                  Icons.password_outlined,
                                                  color: Colors.blue),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    cubit.changeVisibility1();
                                                  },
                                                  icon: cubit.is_scure1
                                                      ? const Icon(
                                                          Icons
                                                              .visibility_outlined,
                                                          color: Colors.blue)
                                                      : const Icon(
                                                          Icons
                                                              .visibility_off_outlined,
                                                          color: Colors.blue)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff085373),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Please enter password";
                                              } else if (value !=
                                                  prefs!
                                                      .getString('password')) {
                                                state is ResetPasswordValidationFailure &&
                                                        state.errors
                                                            .containsKey(
                                                                "password")
                                                    ? Text(
                                                        state.errors[
                                                            "password"]![0],
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Text("");
                                              } else {
                                                return null;
                                              }
                                            },
                                            onEditingComplete: () =>
                                                _focusNodeConfirmPassword
                                                    .requestFocus(),
                                          ),
                                          state is ResetPasswordValidationFailure &&
                                                  state.errors
                                                      .containsKey("password")
                                              ? Text(
                                                  state.errors["password"]![0],
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Text("")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    FractionallySizedBox(
                                      widthFactor: 0.4,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            cursorColor: Colors.blue,
                                            controller:
                                                _controllerConfirmPassword,
                                            obscureText: cubit.is_scure2,
                                            focusNode:
                                                _focusNodeConfirmPassword,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              focusColor: Colors.blue,
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2)),
                                              labelStyle:
                                                  TextStyle(color: Colors.blue),
                                              labelText: "Confirm Password:",
                                              prefixIcon: const Icon(
                                                  Icons.password_outlined,
                                                  color: Colors.blue),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    cubit.changeVisibility2();
                                                  },
                                                  icon: cubit.is_scure2
                                                      ? const Icon(
                                                          Icons
                                                              .visibility_outlined,
                                                          color: Colors.blue)
                                                      : const Icon(
                                                          Icons
                                                              .visibility_off_outlined,
                                                          color: Colors.blue)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff085373),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Please enter confirmation password";
                                              } else if (value !=
                                                  prefs!.getString(
                                                      'passwordConfirm')) {
                                                state is ResetPasswordValidationFailure &&
                                                        state.errors
                                                            .containsKey(
                                                                "password")
                                                    ? Text(
                                                        state.errors[
                                                            "password"]![0],
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Text("");
                                              } else {
                                                return null;
                                              }
                                            },
                                            onEditingComplete: () =>
                                                _focusNodeConfirmPassword
                                                    .requestFocus(),
                                          ),
                                          state is ResetPasswordValidationFailure &&
                                                  state.errors
                                                      .containsKey("password")
                                              ? Text(
                                                  state.errors["password"]![0],
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
                                    Container(
                                        width: 300,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                                          "Email Verified successfully"),
                                                    ),
                                                  );

                                                  _formKey.currentState
                                                      ?.reset();

                                                  if (prefs?.getInt(
                                                          'role_email') ==
                                                      1) {
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
                                                      content: Text(
                                                          "Email Verified successfully"),
                                                    );

                                                    /*showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      content: Text(state.message.toString()),
                    )));*/

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return HotelDrawer();
                                                      },
                                                    ));
                                                  } else if (prefs?.getInt(
                                                          'role_email') ==
                                                      2) {
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
                                                      content: Text(
                                                          "Email Verified successfully"),
                                                    );

                                                    /*showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      content: Text(state.message.toString()),
                    )));*/

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return FlightDrawer();
                                                      },
                                                    ));
                                                  } else if (prefs?.getInt(
                                                          'role_email') ==
                                                      3) {
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
                                                      content: Text(
                                                          "Email Verified successfully"),
                                                    );

                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return AdminDrawer();
                                                        },
                                                      ),
                                                    );
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) =>
                                                            AlertDialog(
                                                              content: Text(
                                                                  'you have no permission to enter this dashboard'),
                                                            )));
                                                  }

                                                  // Navigator.pushReplacement(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) {
                                                  //       return DrawerPage();
                                                  //     },
                                                  //   ),
                                                  // );
                                                },
                                                child: const Text(
                                                  "Skip",
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
                                                  cubit.reset_password(
                                                      code: prefs!
                                                          .getString('data'),
                                                      password:
                                                          _controllerPassword
                                                              .text,
                                                      password_confirmation:
                                                          _controllerConfirmPassword
                                                              .text);
                                                  //           if (_formKey.currentState
                                                  //                   ?.validate() ??
                                                  //               false) {
                                                  //             /* _boxAccounts.put(
                                                  //   _controllerUsername.text,
                                                  //   _controllerConFirmPassword.text,
                                                  // );*/

                                                  //             _formKey.currentState
                                                  //                 ?.reset();
                                                  //             Navigator.pushReplacement(
                                                  //               context,
                                                  //               MaterialPageRoute(
                                                  //                 builder: (context) {
                                                  //                   return Login();
                                                  //                 },
                                                  //               ),
                                                  //             );
                                                  //           }
                                                },
                                                child: const Text(
                                                  "Reset",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
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
