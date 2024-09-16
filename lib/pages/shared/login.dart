import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/login/cubit/login_cubit.dart';
import 'package:reserva/cubits/shared/auth/login/cubit/login_state.dart';
import 'package:reserva/pages/admin/admin_drawer.dart';
import 'package:reserva/pages/company_owner/flights/flight_drawer.dart';
import 'package:reserva/pages/company_owner/hotel/hotel_drawer.dart';
import 'package:reserva/pages/shared/forget_password1.dart';
import 'package:reserva/pages/shared/signup.dart';

import 'package:reserva/widgets/shared/video_player.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  // bool _obscurePassword = true;
  // final Box _boxLogin = Hive.box("login");
  // final Box _boxAccounts = Hive.box("accounts");

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
    /* if (_boxLogin.get("loginStatus") ?? false) {
      return DrawerPage();
    }*/

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.role_id == 1) {
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
          } else if (state.role_id == 2) {
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
          } else if (state.role_id == 3) {
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
        } else if (state is LoginFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
          _formKey.currentState?.reset();
        } else if (state is LoginValidationFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.errors.toString()),
                  )));
        }
      },
      builder: (context, state) {
        return state is LoginLoading
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
                                aspectRatio: 16 / 9,
                                child: //Container()
                                    VideoPlayerWidget()))),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 800,
                        width: 800,
                        /*decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Color(0xffD3E8EB),
                        Color(0xff008BBA),
                      ])),*/
                        /*decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/im1.jpg"), fit: BoxFit.cover)),*/
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/logo4.png",
                                      height: 200,
                                      width: 250,
                                      // height: 200,
                                      //width: 200,
                                    ),
                                    SizedBox(
                                      width: 0,
                                    ),

                                    /*  Text("Reserva",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff083C7B),
                                      fontSize: 70,
                                      fontFamily: "DancingScript"))*/
                                  ],
                                ),
                                Text(
                                  "Login to your account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 20),
                                FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: Column(
                                    children: [
                                      /*IntlPhoneField(
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  initialCountryCode: 'IN',
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                  },
                                )*/
                                      TextFormField(
                                        cursorColor: Colors.blue,
                                        controller: _controllerEmail,
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
                                            Icons.person_outline,
                                            color: Colors.blue,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue),
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
                                        onEditingComplete: () =>
                                            _focusNodePassword.requestFocus(),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter email.";
                                          } else if (value !=
                                              prefs!.getString('email')) {
                                            state is LoginValidationFailure &&
                                                    state.errors
                                                        .containsKey("email")
                                                ? Text(
                                                    state.errors["email"]![0],
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                : Text("");
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      state is LoginValidationFailure &&
                                              state.errors.containsKey("email")
                                          ? Text(
                                              state.errors["email"]![0],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          : Text("")
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        cursorColor: Colors.blue,
                                        controller: _controllerPassword,
                                        focusNode: _focusNodePassword,
                                        obscureText: cubit.is_scure,
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
                                            color: Colors.blue,
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                cubit.changeVisibility();
                                              },
                                              icon: cubit.is_scure
                                                  ? const Icon(
                                                      Icons.visibility_outlined,
                                                      color: Colors.blue,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .visibility_off_outlined,
                                                      color: Colors.blue,
                                                    )),
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
                                          if (value == null || value.isEmpty) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter password.";
                                            } else if (value !=
                                                prefs!.getString('password')) {
                                              state is LoginValidationFailure &&
                                                      state.errors.containsKey(
                                                          "pasword")
                                                  ? Text(
                                                      state.errors["email"]![0],
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  : Text("");
                                            } else {
                                              return null;
                                            }
                                          }
                                        },
                                        onEditingComplete: () =>
                                            _focusNodePassword.requestFocus(),
                                      ),
                                      state is LoginValidationFailure &&
                                              state.errors
                                                  .containsKey("password")
                                          ? Text(
                                              state.errors["password"]![0],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          : Text("")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextButton(
                                  onPressed: () {
                                    _formKey.currentState?.reset();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ForgetPasswordPage1();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Do you forget your password?",
                                    style: TextStyle(
                                        color: Color(0xff085373),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    FractionallySizedBox(
                                      widthFactor: 0.4,
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
                                          cubit.login(
                                            email: _controllerEmail.text,
                                            password: _controllerPassword.text,
                                          );
                                          /*if (_formKey.currentState?.validate() ??
                                        false) {*/
                                          // _boxLogin.put("loginStatus", true);
                                          // _boxLogin.put(
                                          // "userName", _controllerUsername.text);

                                          /*    Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return DrawerPage();
                                              },
                                            ),
                                          );*/
                                          // }
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      _formKey.currentState?.reset();
    
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const Signup();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Signup",
                                      style: TextStyle(
                                          color: Color(0xff085373),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),*/
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    // super.dispose();
  }
}
