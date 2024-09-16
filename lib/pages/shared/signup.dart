import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reserva/widgets/shared/video_player.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  final Box _boxAccounts = Hive.box("accounts");
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
              //color: Colors.blueGrey[100],
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/d.jpg",
                            // height: 200,
                            //width: 200,
                          ),
                          Text(
                            "Register",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff085373),
                                fontSize: 70,
                                fontFamily: "DancingScript"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Create your account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 35),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: Colors.blue,
                              controller: _controllerUsername,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                focusColor: Colors.blue,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Username",
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff085373), width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter username.";
                                } else if (_boxAccounts.containsKey(value)) {
                                  return "Username is already registered.";
                                }

                                return null;
                              },
                              onEditingComplete: () =>
                                  _focusNodeEmail.requestFocus(),
                            ),
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
                              controller: _controllerEmail,
                              focusNode: _focusNodeEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusColor: Colors.blue,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Email",
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff085373), width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter email.";
                                } else if (!(value.contains('@') &&
                                    value.contains('.'))) {
                                  return "Invalid email";
                                }
                                return null;
                              },
                              onEditingComplete: () =>
                                  _focusNodePassword.requestFocus(),
                            ),
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
                              obscureText: _obscurePassword,
                              focusNode: _focusNodePassword,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                focusColor: Colors.blue,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.password_outlined,
                                    color: Colors.blue),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                    icon: _obscurePassword
                                        ? const Icon(Icons.visibility_outlined,
                                            color: Colors.blue)
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.blue)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff085373), width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password.";
                                } else if (value.length < 8) {
                                  return "Password must be at least 8 character.";
                                }
                                return null;
                              },
                              onEditingComplete: () =>
                                  _focusNodeConfirmPassword.requestFocus(),
                            ),
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
                              controller: _controllerConFirmPassword,
                              obscureText: _obscurePassword,
                              focusNode: _focusNodeConfirmPassword,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                focusColor: Colors.blue,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Confirm Password",
                                prefixIcon: const Icon(Icons.password_outlined,
                                    color: Colors.blue),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                    icon: _obscurePassword
                                        ? const Icon(Icons.visibility_outlined,
                                            color: Colors.blue)
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.blue)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff085373), width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password.";
                                } else if (value != _controllerPassword.text) {
                                  return "Password doesn't match.";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff085373),
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _boxAccounts.put(
                                    _controllerUsername.text,
                                    _controllerConFirmPassword.text,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      width: 200,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      content:
                                          const Text("Registered Successfully"),
                                    ),
                                  );

                                  _formKey.currentState?.reset();

                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Login",
                                    style: TextStyle(
                                        color: Color(0xff085373),
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
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
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
