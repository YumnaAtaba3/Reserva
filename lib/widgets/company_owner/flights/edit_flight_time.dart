import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight_time/cubit/edit_flight_time_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight_time/cubit/edit_flight_time_state.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/flight_class.dart';
import 'package:reserva/models/room_features.dart';
import 'package:reserva/models/seat_selection.dart';

import 'package:reserva/widgets/company_owner/flights/time_picker.dart';

import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class EditFlightTime extends StatelessWidget {
  EditFlightTime({super.key, required this.data});
  final FlightTime data;

  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();

  final textFieldKey = GlobalKey();

  String? departDay;

  String? childPrice;

  String? adultPrice;

  String? selectedfCity;

  String? selectedtCity;

  List<CityModel>? cities = [
    CityModel(id: 1, name: 'New York'),
    CityModel(id: 2, name: 'Los Angeles'),
    CityModel(id: 3, name: 'Chicago'),
    CityModel(id: 4, name: 'Houston'),
    CityModel(id: 5, name: 'Phoenix'),
    CityModel(id: 6, name: 'Philadelphia'),
    CityModel(id: 7, name: 'San Antonio'),
    CityModel(id: 8, name: 'San Diego'),
    CityModel(id: 9, name: 'Dallas'),
    CityModel(id: 10, name: 'San Jose')
  ];

  String? selectedClass;

  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditFlightTimeCubit, EditFlightTimeState>(
        listener: (context, state) {
      if (state is EditFlightTimeFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is EditFlightTimeSuccess) {
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
      if (state is EditFlightTimeLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView(children: [
        Container(
          height: 400,
          width: 500,
          child: AlertDialog(
            title: Text(
              "Edit a Flight's Time",
              style: TextStyle(
                  fontFamily: "DancingScript",
                  color: Color(0xFF064061),
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: double.infinity,
              width: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(BlocProvider.of<EditFlightTimeCubit>(context)
                                        .selectedTime1 !=
                                    null
                                ? "${BlocProvider.of<EditFlightTimeCubit>(context).selectedTime1.hour}:${BlocProvider.of<EditFlightTimeCubit>(context).selectedTime1.minute}"
                                : 'Select Time'),
                            Container(
                                child: CustomTimePicker(
                              initialTime:
                                  BlocProvider.of<EditFlightTimeCubit>(context)
                                          .selectedTime1 ??
                                      TimeOfDay.now(),
                              onTimeSelected: (TimeOfDay time) {
                                BlocProvider.of<EditFlightTimeCubit>(context)
                                    .updateSelectedTime1(time);
                                // setState(() {
                                //   selectedTime = time;
                                // });
                              },
                              hourHandColor: Color(0xff90CAF9),
                              themeColor: Color(0xff90CAF9),
                              time: "To-Hour",
                            )),
                          ],
                        ),
                        Column(
                          children: [
                            Text(BlocProvider.of<EditFlightTimeCubit>(context)
                                        .selectedTime2 !=
                                    null
                                ? "${BlocProvider.of<EditFlightTimeCubit>(context).selectedTime2.hour}:${BlocProvider.of<EditFlightTimeCubit>(context).selectedTime2.minute}"
                                : 'Select Time'),
                            Container(
                                child: CustomTimePicker(
                              initialTime:
                                  BlocProvider.of<EditFlightTimeCubit>(context)
                                          .selectedTime2 ??
                                      TimeOfDay.now(),
                              onTimeSelected: (TimeOfDay time) {
                                BlocProvider.of<EditFlightTimeCubit>(context)
                                    .updateSelectedTime2(time);
                                // setState(() {
                                //   selectedTime = time;
                                // });
                              },
                              hourHandColor: Color(0xff90CAF9),
                              themeColor: Color(0xff90CAF9),
                              time: "From-Hour",
                            )),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            initialValue: data.childrenPrice.toString(),
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Child-Price',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the price';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              childPrice = value;
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            initialValue: data.adultPrice.toString(),
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Adult-Price',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the price';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              adultPrice = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          width: 200,
                          // height: 0,
                          margin: const EdgeInsets.all(10),
                          child: TextField(
                            key: textFieldKey,
                            controller: dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: data.departureDay,
                              border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                              /*enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),*/
                              suffixIcon: Icon(Icons.today),
                            ),
                            onTap: () async {
                              final pickedDate = await showWebDatePicker(
                                context: textFieldKey.currentContext!,
                                initialDate: DateTime.now(),
                                firstDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 14000)),
                                width: 300,
                              );
                              if (pickedDate != null) {
                                // _selectedDate = pickedDate;
                                dateController.text =
                                    pickedDate.toString().split(' ')[0];
                              }
                            },
                          ),
                        ),
                      ),
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
                        BlocProvider.of<EditFlightTimeCubit>(context)
                            .EditFlightTime(
                                id: data.id,
                                to_hour:
                                    //"13:00",
                                    BlocProvider.of<EditFlightTimeCubit>(
                                            context)
                                        .selectedTime1,
                                from_hour:
                                    // "14:00",
                                    BlocProvider.of<EditFlightTimeCubit>(
                                            context)
                                        .selectedTime2,
                                departure_day: dateController.text == null
                                    ? data.departureDay.toString()
                                    : dateController.text,
                                children_price: childPrice == null
                                    ? data.childrenPrice.toString()
                                    : childPrice!,
                                adult_price: adultPrice == null
                                    ? data.adultPrice.toString()
                                    : adultPrice!);
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
