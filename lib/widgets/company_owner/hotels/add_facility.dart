import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_facility/cubit/add_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_facility/cubit/add_facility_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_cubit.dart';

class AddFacility extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _facilityName = '';
  final TextEditingController _controllerFacilityName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFacilityCubit, AddFacilityState>(
      listener: (context, state) {
        if (state is AddFacilityFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
        }
        if (state is AddFacilitySuccess) {
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
        if (state is AddFacilityLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return AlertDialog(
          title: Text(
            'Add Facility',
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
              controller: _controllerFacilityName,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.blue),
                labelText: 'Facility Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a facility name';
                }
                return null;
              },
              onSaved: (value) {
                _facilityName = value!;
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
                      BlocProvider.of<AddFacilityCubit>(context).AddFacility(
                        facility_name: _controllerFacilityName.text,
                      );
                    }
                    BlocProvider.of<ShowFacilityCubit>(context)
                        .getAllFacilities();
                    // if (_formKey.currentState!.validate()) {
                    //   _formKey.currentState!.save();

                    //   Navigator.pop(context);
                    // }
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
