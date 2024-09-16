import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
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

class AddFlight extends StatelessWidget {
  AddFlight({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  TextEditingController childPriceController = TextEditingController();
  TextEditingController adultPriceController = TextEditingController();
  TextEditingController seatsNumController = TextEditingController();
  TextEditingController seatSelec1Controller = TextEditingController();
  TextEditingController seatSelec2Controller = TextEditingController();
  TextEditingController seatSelec3Controller = TextEditingController();

  final textFieldKey = GlobalKey();
  // TimeOfDay selectedTime = TimeOfDay.now();
  // TimeOfDay selectedTime2 = TimeOfDay.now();
  bool checked_bag = false;
  bool hand_bag = false;
  String _departDay = '';

  String _toHour = '';
  String _fromHour = '';
  String _seatsNum = '';
  String _seatSelection = '';
  String _childPrice = '';
  String _adultPrice = '';
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
    return BlocConsumer<AddFlightCubit, AddFlightState>(
        listener: (context, state) {
      if (state is AddFlightFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is AddFlightSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 200,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            content: const Text("Created Successfully"),
          ),
        );

        _formKey.currentState?.reset();
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is AddFlightLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView(children: [
        Container(
          height: 600,
          width: 700,
          child: AlertDialog(
            title: Text(
              'Add a Flight',
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
                    /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 316,
                        child: ClassDropDown(
                          onChanged: (value) {
                            selectedClass = value;
                          },
                          // onTap: () {
                          //   BlocProvider.of<AddMedicineCubit>(context)
                          //       .getFilters();
                          // },
                          // textEditingController: category,
                          title: 'Flight-Class',
                          hint: 'Select a Class',
                          isdropSelected: true,
                          dataList: classes,
                          selectedValue: selectedClass,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Seat-Selection',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the seat selection';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _seatSelection = value!;
                          },
                        ),
                      ),
                      // Container(
                      //   width: 200,
                      //   child: SeatDropDown(
                      //     onChanged: (value) {
                      //       selectedSeat = value;
                      //     },
                      //     // onTap: () {
                      //     //   BlocProvider.of<AddMedicineCubit>(context)
                      //     //       .getFilters();
                      //     // },
                      //     // textEditingController: category,
                      //     title: 'Seat-Selection',
                      //     hint: 'Select a Seat',
                      //     isdropSelected: true,
                      //     dataList: seats,
                      //     selectedValue: selectedSeat,
                      //   ),
                      // ),
                    ],
                  ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              controller: seatSelec1Controller,
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
                              onSaved: (value) {
                                _seatsNum = value!;
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
                              controller: seatSelec2Controller,
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
                              onSaved: (value) {
                                _seatsNum = value!;
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
                              controller: seatSelec3Controller,
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
                              onSaved: (value) {
                                _seatsNum = value!;
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
                            hint: 'Select a City',
                            isdropSelected: true,
                            dataList:
                                BlocProvider.of<AddFlightCubit>(context).cities,
                            selectedValue: selectedfCity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              controller: seatsNumController,
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
                              onSaved: (value) {
                                _seatsNum = value!;
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
                            hint: 'Select a City',
                            isdropSelected: true,
                            dataList:
                                BlocProvider.of<AddFlightCubit>(context).cities,
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
                                value: BlocProvider.of<AddFlightCubit>(context)
                                    .checkboxValue,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  BlocProvider.of<AddFlightCubit>(context)
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
                                value: BlocProvider.of<AddFlightCubit>(context)
                                    .handboxValue,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  BlocProvider.of<AddFlightCubit>(context)
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
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          "Flight's Time",
                          style: TextStyle(
                              fontFamily: "DancingScript",
                              color: Color(0xFF064061),
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(BlocProvider.of<AddFlightCubit>(context)
                                        .selectedTime1 !=
                                    null
                                ? "${BlocProvider.of<AddFlightCubit>(context).selectedTime1.hour}:${BlocProvider.of<AddFlightCubit>(context).selectedTime1.minute}"
                                : 'Select Time'),
                            Container(
                                child: CustomTimePicker(
                              initialTime:
                                  BlocProvider.of<AddFlightCubit>(context)
                                          .selectedTime1 ??
                                      TimeOfDay.now(),
                              onTimeSelected: (TimeOfDay time) {
                                BlocProvider.of<AddFlightCubit>(context)
                                    .updateSelectedTime1(time);
                                // setState(() {
                                //   selectedTime = time;
                                // });
                              },
                              hourHandColor: Color(0xff90CAF9),
                              themeColor: Color(0xff90CAF9),
                              time: "To-Hour",
                            ) /*Column(
                                  children: [
                                    Text(
                                        "${selectedTime.hour}:${selectedTime.minute}"),
                                    Container(
                                      width: 200,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            final TimeOfDay? timeOfDay =
                                                await showTimePicker(
                                                    context: context,
                                                    initialTime: selectedTime,
                                                    initialEntryMode:
                                                        TimePickerEntryMode.dial);
                                            if (timeOfDay != null) {
                                              setState(() {
                                                selectedTime = timeOfDay;
                                              });
                                            }
                                          },
                                          child: Text("From-Hour",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ))),
                                    )
                                  ],
                                )
                                */
                                ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(BlocProvider.of<AddFlightCubit>(context)
                                        .selectedTime2 !=
                                    null
                                ? "${BlocProvider.of<AddFlightCubit>(context).selectedTime2.hour}:${BlocProvider.of<AddFlightCubit>(context).selectedTime2.minute}"
                                : 'Select Time'),
                            Container(
                                child: CustomTimePicker(
                              initialTime:
                                  BlocProvider.of<AddFlightCubit>(context)
                                          .selectedTime2 ??
                                      TimeOfDay.now(),
                              onTimeSelected: (TimeOfDay time) {
                                BlocProvider.of<AddFlightCubit>(context)
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
                          padding: EdgeInsets.only(top: 5),
                          width: 200,
                          // height: 0,
                          margin: const EdgeInsets.all(2),
                          child: TextField(
                            key: textFieldKey,
                            controller: dateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: "Depart Day",
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
                      BlocProvider.of<AddFlightCubit>(context).AddFlight(
                          to_hour: BlocProvider.of<AddFlightCubit>(context)
                              .selectedTime1,
                          from_hour: BlocProvider.of<AddFlightCubit>(context)
                              .selectedTime2,
                          departure_day: dateController.text,
                          children_price: childPriceController.text,
                          adult_price: adultPriceController.text,
                          from_city_id: selectedfCity!,
                          to_city_id: selectedtCity!,
                          seat_selection1: seatSelec1Controller.text,
                          seat_selection2: seatSelec2Controller.text,
                          seat_selection3: seatSelec3Controller.text,
                          seats_num: seatsNumController.text,
                          checked_bag: BlocProvider.of<AddFlightCubit>(context)
                              .checkboxValue,
                          hand_bag: BlocProvider.of<AddFlightCubit>(context)
                              .handboxValue);
                      BlocProvider.of<ShowFlightCubit>(context).showFlights();
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
    });
  }
}
