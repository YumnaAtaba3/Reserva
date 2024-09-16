import 'package:flutter/material.dart';
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

class EditFlightReservations extends StatefulWidget {
  const EditFlightReservations({super.key});

  @override
  State<EditFlightReservations> createState() => _EditFlightReservationsState();
}

class _EditFlightReservationsState extends State<EditFlightReservations> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final textFieldKey = GlobalKey();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool paid = false;
  bool checked_bag = false;
  bool hand_bag = false;
  String _departDay = '';

  String _email = '';
  String _phoneNum = '';
  String _userName = '';
  String _childNum = '';
  String _adultNum = '';
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
    return ListView(children: [
      Container(
        height: 600,
        width: 500,
        child: AlertDialog(
          title: Text(
            'Edit the reservation:',
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
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'User Name:',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a room details';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value!;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Email:',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a room details';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
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
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Phone number:',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the number of beds';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phoneNum = value!;
                          },
                        ),
                      ),
                      Container(
                        width: 200,
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
                          dataList: cities,
                          selectedValue: selectedfCity,
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
                          dataList: cities,
                          selectedValue: selectedtCity,
                        ),
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
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Child-Number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the price';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _childNum = value!;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Adult-Number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the price';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _adultNum = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: paid,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                setState(() {
                                  paid = val!;
                                });
                              }),
                          Text(
                            "Paid",
                            style: TextStyle(
                                color: Color(0xFF064061),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
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
                      _formKey.currentState!.save();

                      Navigator.pop(context);
                      /*  Navigator.pushNamed(
                      context,
                      'Category',
                    );*/
                    }
                  },
                  child:
                      Text('Edit', style: TextStyle(color: Color(0xFF064061))),
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
  }
}
