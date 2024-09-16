import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_service/cubit/add_service_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_service/cubit/add_service_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_service/cubit/show_service_cubit.dart';

class AddService extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? _serviceName;
  final TextEditingController _controllerServiceName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddServiceCubit, AddServiceState>(
      listener: (context, state) {
        if (state is AddServiceFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
        }
        if (state is AddServiceSuccess) {
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

          _formKey.currentState?.reset();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is AddServiceLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return AlertDialog(
          title: Text(
            'Add Service',
            style: TextStyle(
                color: Color(0xFF064061),
                fontFamily: "DancingScript",
                fontSize: 35,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _controllerServiceName,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.blue),
                labelText: 'Service Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a service name';
                }
                return null;
              },
              onSaved: (value) {
                _serviceName = value!;
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xFF064061)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      BlocProvider.of<AddServiceCubit>(context).AddService(
                        service_name: _controllerServiceName.text,
                      );
                    }
                    BlocProvider.of<ShowServiceCubit>(context).getAllServices();
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(color: Color(0xFF064061)),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
