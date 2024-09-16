import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/logout/cubit/logout_cubit.dart';
import 'package:reserva/cubits/shared/auth/logout/cubit/logout_state.dart';
import 'package:reserva/pages/shared/login.dart';

class LogoutDialog extends StatelessWidget {
  //final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    LogoutCubit cubit = BlocProvider.of<LogoutCubit>(context);
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
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
              return Login();
            },
          ));
        } else if (state is LogoutFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
        }
      },
      builder: (context, state) {
        return state is LogoutLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : AlertDialog(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF064061),
                      fontSize: 40,
                      fontFamily: "DancingScript"),
                  textAlign: TextAlign.center,
                ),
                content: Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.logout();
                      /* prefs!.remove('token');
                _boxLogin.clear();
                _boxLogin.put("loginStatus", false);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);*/
                    },
                    child: Text('Logout', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              );
      },
    );
  }
}
/*
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false);*/