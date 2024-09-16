import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_state.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_facility/cubit/edit_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_facility/cubit/edit_facility_state.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class EditFacility extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  bool wifi = false;
  bool meals = false;
  bool parking = false;
  bool childActiv = false;

  EditFacility({super.key});

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<ShowFacilityCubit>(context).getAllFacilities();

    return BlocBuilder<ShowFacilityCubit, ShowFacilityState>(
      builder: (context, state) {
        if (state is ShowFacilityFailure) {
          return const Center(
            child: Text("Something went wrong please again"),
          );
        } else if (state is ShowFacilityLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ShowFacilitySuccess) {
          return AlertDialog(
            title: Text(
              'Edit Facility',
              style: TextStyle(
                  color: Color(0xFF064061),
                  fontFamily: "DancingScript",
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: BlocBuilder<EditFacilityCubit, EditFacilityState>(
              builder: (context, state2) {
                return Container(
                  height: 100,
                  child: Row(
                    children: [
                      for (int i = 0; i < state.facilities.length; i++)
                        Expanded(
                          child: Row(
                            children: [
                              // SizedBox(width: 100),
                              Checkbox(
                                value: state.facilities[i].enabled,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  // BlocProvider.of<EditFacilityCubit>(context)
                                  //     .ChangeFacility(
                                  //         facilities: state.facilities,
                                  //         index: i,
                                  //         context: context);
                                  BlocProvider.of<EditFacilityCubit>(context)
                                      .ChangeFacility(
                                          id: state.facilities[i].id,
                                          facility_name:
                                              state.facilities[i].facilityName,
                                          enabled: val!,
                                          context: context);
                                  BlocProvider.of<ShowFacilityCubit>(context)
                                      .getAllFacilities();
                                },
                              ),
                              Expanded(
                                child: Text(
                                  state.facilities[i].facilityName,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              //SizedBox(width: 100),
                            ],
                          ),
                        ),
                    ],
                  ),
                  /*Row(
                            children: [
                              Checkbox(
                                  value: wifi,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      wifi = val!;
                                    });
                                  }),
                              Text(
                                "Wifi",
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Checkbox(
                                  value: meals,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      meals = val!;
                                    });
                                  }),
                              Text(
                                "Meals",
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Checkbox(
                                  value: parking,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      parking = val!;
                                    });
                                  }),
                              Text(
                                "Parking",
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Checkbox(
                                  value: childActiv,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      childActiv = val!;
                                    });
                                  }),
                              Text(
                                "Children Activities",
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ],
                          )*/

                  /*Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.blue),
                                  labelText: 'Meals',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a service name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _name = value!;
                                },
                              ),
                              TextFormField(
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.blue),
                                  labelText: 'WiFi',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a service name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _name = value!;
                                },
                              ),
                              TextFormField(
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.blue),
                                  labelText: 'Children Activities',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a service name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _name = value!;
                                },
                              ),
                              TextFormField(
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.blue),
                                  labelText: 'Parking',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a service name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _name = value!;
                                },
                              ),
                            ],
                          ),
                        ),*/
                );
              },
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
                      // if (_formKey.currentState!.validate()) {
                      // _formKey.currentState!.save();
                      BlocProvider.of<ShowFacilityCubit>(context)
                          .getAllFacilities();
                      // Navigator.pop(context);
                      // }
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Color(0xFF064061)),
                    ),
                  )
                ],
              ),
            ],
          );
        } else {
          return const Text("Something is wrong");
        }
      },
    );
  }
}
/*class EditFacility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditFacilityCubit(facilities: []),
      child: BlocBuilder<EditFacilityCubit, EditFacilityState>(
        builder: (context, state) {
          if (state is EditFacilityFailure) {
            return const Center(
              child: Text("Something went wrong, please try again"),
            );
          } else if (state is EditFacilityLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EditFacilitySuccess) {
            final facilities = state.facilities;
            return AlertDialog(
              title: Text(
                'Edit Facility',
                style: TextStyle(
                  color: Color(0xFF064061),
                  fontFamily: "DancingScript",
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: facilities.length,
                  itemBuilder: (context, index) {
                    final facility = facilities[index];
                    return CheckboxListTile(
                      title: Text(facility.facilityName),
                      value: facility.enabled,
                      onChanged: (value) {
                        context.read<EditFacilityCubit>().changeFacility(
                              id: facility.id,
                              facility_name: facility.facilityName,
                              enabled: value!,
                              context: context,
                            );
                      },
                    );
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Color(0xFF064061)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Text("Something is wrong");
          }
        },
      ),
    );
  }
}*/
