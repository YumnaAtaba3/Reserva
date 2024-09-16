import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/models/room_features.dart';
import 'package:reserva/widgets/company_owner/hotels/feature_drop_down.dart';
import 'package:reserva/widgets/company_owner/hotels/type_drop_down.dart';
import 'package:reserva/widgets/shared/drop_down_list.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class EditHotelReservations extends StatefulWidget {
  const EditHotelReservations({super.key});

  @override
  State<EditHotelReservations> createState() => _EditHotelReservationsState();
}

class _EditHotelReservationsState extends State<EditHotelReservations> {
  FilePickerResult? result;
  TextEditingController _imageController = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController1 = TextEditingController();
  final textFieldKey1 = GlobalKey();
  TextEditingController dateController2 = TextEditingController();
  final textFieldKey2 = GlobalKey();
  String _userName = '';
  String _email = '';
  String _phoneNum = '';

  bool paid = false;
  String? selectedType;
  List<RoomType>? types = [
    // RoomType(id: 1, name: 'Deluxe twin room'),
    // RoomType(id: 2, name: 'Deluxe triple rrom'),
    // RoomType(id: 3, name: 'Single room'),
    // RoomType(id: 4, name: 'Connected rrom'),
    // RoomType(id: 5, name: 'Smoking room'),
    // RoomType(id: 6, name: 'Non Smoking room'),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          height: 300,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: RoomTypeDropDown(
                          onChanged: (value) {
                            selectedType = value;
                          },
                          // onTap: () {
                          //   BlocProvider.of<AddMedicineCubit>(context)
                          //       .getFilters();
                          // },
                          // textEditingController: category,
                          title: ' Room Type',
                          hint: 'Select a Type',
                          isdropSelected: true,
                          dataList: types,
                          selectedValue: selectedType,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
                        key: textFieldKey1,
                        controller: dateController1,
                        readOnly: true,
                        decoration: const InputDecoration(
                          filled: true,
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "From Day",
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          /*enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),*/
                          suffixIcon: Icon(Icons.today),
                        ),
                        onTap: () async {
                          final pickedDate = await showWebDatePicker(
                            context: textFieldKey1.currentContext!,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().add(const Duration(days: 1)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 14000)),
                            width: 300,
                          );
                          if (pickedDate != null) {
                            // _selectedDate = pickedDate;
                            dateController1.text =
                                pickedDate.toString().split(' ')[0];
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: 200,
                      // height: 0,
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                        key: textFieldKey2,
                        controller: dateController2,
                        readOnly: true,
                        decoration: const InputDecoration(
                          filled: true,
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: "To Day",
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          /*enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),*/
                          suffixIcon: Icon(Icons.today),
                        ),
                        onTap: () async {
                          final pickedDate = await showWebDatePicker(
                            context: textFieldKey2.currentContext!,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().add(const Duration(days: 1)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 14000)),
                            width: 300,
                          );
                          if (pickedDate != null) {
                            // _selectedDate = pickedDate;
                            dateController2.text =
                                pickedDate.toString().split(' ')[0];
                          }
                        },
                      ),
                    ),
                  ],
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
                child: Text('Edit', style: TextStyle(color: Color(0xFF064061))),
              ),
            ],
          ),
          // BlocListener<CategoryCubit, CategoryState>(
          // listener: (context, state) {},
          //child:
        ],
      ),
    );
  }
}
