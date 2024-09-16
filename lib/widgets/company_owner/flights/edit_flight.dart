import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight/cubit/edit_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight/cubit/edit_flight_state.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/models/flight_class.dart';

import 'package:reserva/models/seat_selection.dart';
import 'package:reserva/widgets/company_owner/flights/class_drop_down.dart';

import 'package:reserva/widgets/shared/drop_down_list.dart';

class EditFlight extends StatelessWidget {
  EditFlight({super.key, required this.data});
  final Flight data;
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();

  final textFieldKey = GlobalKey();

  TimeOfDay selectedTime = TimeOfDay.now();

  bool checked_bag = false;

  bool hand_bag = false;

  String? departDay;

  String? seatSelect1;
  String? seatSelect2;
  String? seatSelect3;

  String? seatsNum;

  String? childPrice;

  String? adultPrice;

  String? selectedfCity;

  String? selectedtCity;

  List<City>? cities = [
    // CityModel(id: 1, name: 'New York'),
    // CityModel(id: 2, name: 'Los Angeles'),
    // CityModel(id: 3, name: 'Chicago'),
    // CityModel(id: 4, name: 'Houston'),
    // CityModel(id: 5, name: 'Phoenix'),
    // CityModel(id: 6, name: 'Philadelphia'),
    // CityModel(id: 7, name: 'San Antonio'),
    // CityModel(id: 8, name: 'San Diego'),
    // CityModel(id: 9, name: 'Dallas'),
    // CityModel(id: 10, name: 'San Jose')
  ];

  String? selectedClass;

  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditFlightCubit, EditFlightState>(
        listener: (context, state) {
      if (state is EditFlightFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is EditFlightSuccess) {
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
        BlocProvider.of<ShowFlightCubit>(context).showFlights();
      }
    }, builder: (context, state) {
      if (state is EditFlightLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView(children: [
        Container(
          height: 420,
          width: 500,
          child: AlertDialog(
            title: Text(
              'Edit a Flight',
              style: TextStyle(
                  fontFamily: "DancingScript",
                  color: Color(0xFF064061),
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: double.infinity,
              width: 650,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              initialValue: data.flightClasses[0].seatSelection,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Economy Class',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the seats number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                seatSelect1 = value;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              initialValue: data.flightClasses[1].seatSelection,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'First Class',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the seats number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                seatSelect2 = value;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              initialValue: data.flightClasses[2].seatSelection,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Business Class',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the seats number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                seatSelect3 = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: DropDown(
                            onChanged: (value) {
                              selectedfCity = value;
                            },
                            // onTap: () {
                            //   BlocProvider.of<AddMedicineCubit>(context)
                            //       .getFilters();
                            // },
                            // textEditingController: category,
                            title: 'From-City',
                            hint: data.fromCity.cityName,
                            isdropSelected: true,
                            dataList: BlocProvider.of<EditFlightCubit>(context)
                                .cities,
                            selectedValue: selectedfCity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              initialValue: data.seatsNum.toString(),
                              //controller: seatsNumController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Seats Number',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the seats number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                seatsNum = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: DropDown(
                            onChanged: (value) {
                              selectedtCity = value;
                            },
                            // onTap: () {
                            //   BlocProvider.of<AddMedicineCubit>(context)
                            //       .getFilters();
                            // },
                            // textEditingController: category,
                            title: 'To-City',
                            hint: data.toCity.cityName,
                            isdropSelected: true,
                            dataList: BlocProvider.of<EditFlightCubit>(context)
                                .cities,
                            selectedValue: selectedtCity,
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         height: 50,
                    //         width: 150,
                    //         child: TextFormField(
                    //           cursorColor: Colors.blue,
                    //           decoration: InputDecoration(
                    //             labelStyle: TextStyle(color: Colors.blue),
                    //             labelText: 'Seat-Selection',
                    //           ),
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'Please enter the seat selection';
                    //             }
                    //             return null;
                    //           },
                    //           onSaved: (value) {
                    //             _seatSelection = value!;
                    //           },
                    //         ),
                    //       ),
                    //       Container(
                    //         height: 50,
                    //         width: 200,
                    //         child: TextFormField(
                    //           cursorColor: Colors.blue,
                    //           decoration: InputDecoration(
                    //             labelStyle: TextStyle(color: Colors.blue),
                    //             labelText: 'Seats-Num',
                    //           ),
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'Please enter the seats number';
                    //             }
                    //             return null;
                    //           },
                    //           onSaved: (value) {
                    //             _seatsNum = value!;
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value:
                                    // data.checkedBag,
                                    BlocProvider.of<EditFlightCubit>(context)
                                        .checkboxValue,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  BlocProvider.of<EditFlightCubit>(context)
                                      .toggleCheckedbox();
                                  // setState(() {
                                  //   checked_bag = val!;
                                  // });
                                }),
                            Text(
                              "Checked Bag",
                              style: TextStyle(color: Color(0xFF064061)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: BlocProvider.of<EditFlightCubit>(context)
                                    .handboxValue,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  BlocProvider.of<EditFlightCubit>(context)
                                      .toggleHandbox();
                                  // setState(() {
                                  //   hand_bag = val!;
                                  // });
                                }),
                            Text(
                              "Hand Bag",
                              style: TextStyle(color: Color(0xFF064061)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<EditFlightCubit>(context).EditFlight(
                            from_city_id: selectedfCity == null
                                ? data.fromCity.id.toString()
                                : selectedfCity!,
                            to_city_id: selectedtCity == null
                                ? data.toCity.id.toString()
                                : selectedtCity!,
                            seat_selection1: seatSelect1 == null
                                ? data.flightClasses[0].seatSelection
                                : seatSelect1!,
                            seat_selection2: seatSelect1 == null
                                ? data.flightClasses[1].seatSelection
                                : seatSelect2!,
                            seat_selection3: seatSelect1 == null
                                ? data.flightClasses[2].seatSelection
                                : seatSelect3!,
                            seats_num: seatsNum == null
                                ? data.seatsNum.toString()
                                : seatsNum!,
                            checked_bag:
                                BlocProvider.of<EditFlightCubit>(context)
                                    .checkboxValue,
                            hand_bag: BlocProvider.of<EditFlightCubit>(context)
                                .handboxValue,
                            id: data.id);
                        BlocProvider.of<ShowFlightCubit>(context).showFlights();
                      }
                    },
                    child: Text('Edit',
                        style: TextStyle(color: Color(0xFF064061))),
                  ),
                ],
              ),
              // BlocListener<CategoryCubit, CategoryState>(
              // listener: (context, state) {},
              //child:
            ],
          ),
        ),
      ]);
    });
  }
}
