import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_state.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight_time/cubit/add_flight_time_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight_time/cubit/add_flight_time_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/flight_class.dart';
import 'package:reserva/models/room_features.dart';
import 'package:reserva/models/seat_selection.dart';
import 'package:reserva/widgets/company_owner/flights/class_drop_down.dart';
import 'package:reserva/widgets/company_owner/flights/seat_Drop_down.dart';
import 'package:reserva/widgets/company_owner/flights/time_picker.dart';
import 'package:reserva/widgets/company_owner/hotels/feature_drop_down.dart';
import 'package:reserva/widgets/company_owner/hotels/type_drop_down.dart';
import 'package:reserva/widgets/shared/drop_down_list.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

import '../../../models/room_type.dart';

class AddFlightTime extends StatelessWidget {
  AddFlightTime({super.key, required this.data});
  final int data;
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController childPriceController = TextEditingController();
  TextEditingController adultPriceController = TextEditingController();
  final textFieldKey = GlobalKey();
  // TimeOfDay selectedTime = TimeOfDay.now();
  // TimeOfDay selectedTime2 = TimeOfDay.now();
  bool checked_bag = false;
  bool hand_bag = false;
  String _departDay = '';

  String _toHour = '';
  String _fromHour = '';
  String _seatsNum = '';
  String _childPrice = '';
  String _adultPrice = '';
  // String? selectedfCity;
  // String? selectedtCity;
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
  List<FlightClass>? classes = [
    FlightClass(id: 1, name: 'First Class'),
    FlightClass(id: 2, name: 'Business Class'),
    FlightClass(id: 3, name: 'Economy Class'),
  ];

  List<SeatSelection>? seats = [
    SeatSelection(id: 1, name: 'A1'),
    SeatSelection(id: 2, name: 'A2'),
    SeatSelection(id: 3, name: 'A3'),
    SeatSelection(id: 4, name: 'A4'),
    SeatSelection(id: 5, name: 'A5'),
    SeatSelection(id: 6, name: 'B1'),
    SeatSelection(id: 7, name: 'B2'),
    SeatSelection(id: 8, name: 'C1'),
    SeatSelection(id: 9, name: 'C2'),
    SeatSelection(id: 10, name: 'D')
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlightTimeCubit, AddFlightTimeState>(
      listener: (context, state) {
        if (state is AddFlightTimeFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
        }
        if (state is AddFlightTimeSuccess) {
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
        if (state is AddFlightTimeLoading) {
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
                "Add a Flight's Time",
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
                              Text(BlocProvider.of<AddFlightCubit>(context)
                                          .selectedTime1 !=
                                      null
                                  ? "${BlocProvider.of<AddFlightTimeCubit>(context).selectedTime1.hour}:${BlocProvider.of<AddFlightTimeCubit>(context).selectedTime1.minute}"
                                  : 'Select Time'),
                              Container(
                                  child: CustomTimePicker(
                                initialTime:
                                    BlocProvider.of<AddFlightTimeCubit>(context)
                                            .selectedTime1 ??
                                        TimeOfDay.now(),
                                onTimeSelected: (TimeOfDay time) {
                                  BlocProvider.of<AddFlightTimeCubit>(context)
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
                              Text(BlocProvider.of<AddFlightCubit>(context)
                                          .selectedTime2 !=
                                      null
                                  ? "${BlocProvider.of<AddFlightTimeCubit>(context).selectedTime2.hour}:${BlocProvider.of<AddFlightTimeCubit>(context).selectedTime2.minute}"
                                  : 'Select Time'),
                              Container(
                                  child: CustomTimePicker(
                                initialTime:
                                    BlocProvider.of<AddFlightTimeCubit>(context)
                                            .selectedTime2 ??
                                        TimeOfDay.now(),
                                onTimeSelected: (TimeOfDay time) {
                                  BlocProvider.of<AddFlightTimeCubit>(context)
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
                              controller: childPriceController,
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
                              onSaved: (value) {
                                _childPrice = value!;
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              controller: adultPriceController,
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
                              onSaved: (value) {
                                _adultPrice = value!;
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
                              decoration: const InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Depart Day",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
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
                                  firstDate: DateTime.now()
                                      .add(const Duration(days: 1)),
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
                        BlocProvider.of<AddFlightTimeCubit>(context)
                            .AddFlightTime(
                                id: data,
                                to_hour:
                                    //"13:00",
                                    BlocProvider.of<AddFlightTimeCubit>(context)
                                        .selectedTime1,
                                from_hour:
                                    // "14:00",
                                    BlocProvider.of<AddFlightTimeCubit>(context)
                                        .selectedTime2,
                                departure_day: dateController.text,
                                children_price: childPriceController.text,
                                adult_price: adultPriceController.text);
                        BlocProvider.of<ShowFlightCubit>(context).showFlights();

                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        //   Navigator.pop(context);
                        // }
                      },
                      child: Text('Create',
                          style: TextStyle(color: Color(0xFF064061))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
