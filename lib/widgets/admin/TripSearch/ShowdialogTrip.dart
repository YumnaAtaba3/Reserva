

// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, avoid_single_cascade_in_expression_statements

import 'dart:html';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/AddTrip/add_trip_cubit.dart';
import 'package:reserva/cubits/admin/Trip/trip_cubit.dart';
import 'package:reserva/models/admin/service.dart';
import 'package:reserva/widgets/admin/TripSearch/dropDowenTrip.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class Add_Trip extends StatelessWidget {
  Add_Trip({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  FilePickerResult? result;

  TextEditingController _imageController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController _tripnameController = TextEditingController();
    TextEditingController _destinationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
    TextEditingController _requiredAgeController = TextEditingController();
      TextEditingController _numberOfDaysController = TextEditingController();
        TextEditingController _maxNumberOfpeopleController = TextEditingController();
          TextEditingController _tripDetailsController = TextEditingController();
            TextEditingController _tripProgrammeController = TextEditingController();
            
//List<Service>? types= [];
 List<String>? selectedFeature=[] ;
  final textFieldKey = GlobalKey();
  List<Service>? features=[] ;

  String? tripname;
  String? price;
  String? image;
  String? destination;
  String? requiredAge;
  int? numberOfDays;
  int? maxNumberOfPeople;
  String? tripDetails;
  String? tripProgramme;
        
  Widget build(BuildContext context) {
    return BlocConsumer<AddTripCubit, AddTripState>(
        listener: (context, state) {
      if (state is AddTripFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is AddTripSuccess) {
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
          BlocProvider.of<TripCubit>(context)..showAllTrip();
        Navigator.pop(context);
        BlocProvider.of<TripCubit>(context)..showAllTrip();
      }
    }, builder: (context, state) {
      if (state is AddTripLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView(
        children: [
          Container(
            width: 500,
            child: AlertDialog(
              title: Text(
                'Add your information:',
                style: TextStyle(
                    fontFamily: "DancingScript",
                    color: Color(0xFF064061),
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
                textAlign: TextAlign.center,
              ),
              content: Container(
                // height: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     // SizedBox(width:1000 ,),
                      Row(
                            children: [
                              Expanded(
                                child:
                                  TextFormField(
                                controller: _tripnameController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.blue
                                  ),
                                  labelText: 'Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Trip name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  tripname = value;
                                },
                                                    ),
                              ),
                              Expanded(
                            child: TextFormField(
                              controller: _destinationController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Destination',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the destination';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                destination = value;
                              },
                            ),
                          ),
                          SizedBox(width: 20,),
                           Expanded(
                                child: TextFormField(
                                  controller: _priceController,
                                  cursorColor: Colors.blue,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.blue),
                                    labelText: 'Price ',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the price ';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    price = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                      
                      Row(
                            children: [
                              
                             
                            Expanded(
                            child: TextFormField(
                              controller: _requiredAgeController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Required Age',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the  required Age';
                                }
                                return null;
                              },
                            onChanged: (value) {
                                requiredAge = value;
                              },
                            ),
                          ),  SizedBox(
                            width: 20,
                          ),
                              Expanded(
                            child: TextFormField(
                              controller:_numberOfDaysController ,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: ' Number Of Days',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the  number Of Days';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                numberOfDays =int.tryParse(value);
                              },
                            ),
                          ),
                           SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _maxNumberOfpeopleController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Max Number Of People',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the  maxNumberOfPeople';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                maxNumberOfPeople = int.tryParse(value);
                              },
                            ),
                          ),
                            ],
                          ),
                     
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _tripDetailsController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: 'Trip Details',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the  tripDetails';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                tripDetails = value!;
                              },
                            ),
                          ),
                              SizedBox(
                            width: 20,
                          ),
            Expanded(
              child: TextFormField(
          controller:_tripProgrammeController,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Trip programme',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the  trip programme';
                            }
                            return null;
                          },
                         onChanged: (value) {
                            tripProgramme = value!;
                          },
                        ),
            ),
                        ],
                      ),
          
          
                            
                            
          
                              
                          
            
          
                          Row(
                            children: [
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
                                          width: 250,
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
          
                              SizedBox(width: 400,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                    width:330,
                                  child: TripDropDown(
                                    onChanged: (value) {
                                      selectedFeature =
                                          value?.split(',').toList() ?? [];
                                      // selectedFeature = value as List<String>;
                                    },
                                    title: 'services',
                                    hint: 'Select a servise',
                                    isdropSelected: true,
                                  dataList: BlocProvider.of<AddTripCubit>(context).services ?? [],
                                    selectedValues: selectedFeature!,
                                  ),
                                ),
                              ),
                            SizedBox(width: 50,)
                            ],
                          ),
                      
                      
                      Container(
                        height: 75,
                        width: 300,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _imageController,
                                decoration: InputDecoration(
                                  labelText: 'Image Path and Name',
                                ),
                              ),
                            ),
                            Container(
                              
                              child: ElevatedButton(
                                onPressed: () async {
                                  result = await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                  );
                                  
                                  if (result != null) {
                                    PlatformFile file = result!.files.first;
                                    String imageName = file.name;
                                  
                                    _imageController.text = imageName;
                                  
                                    // User has selected an image
                                    final fileBytes = result!.files.single.bytes;
                                    //fileBytes = result!.files.single.bytes?.toList();
                                  
                                    if (fileBytes != null) {
                                      // Image bytes are available
                                      BlocProvider.of<AddTripCubit>(context)
                                          .fileBytes = fileBytes;
                                    }
                                  }
                                },
                                child: Text(
                                  'Select Image',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                          BlocProvider.of<TripCubit>(context).showAllTrip();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFF064061)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //               if (_formKey.currentState!.validate()) {
                        //                 if (select_city != null && select_type != null ) {
                        print(tripname);
                        print(destination);
                          print(price);
                            print(requiredAge);
                              print(maxNumberOfPeople.toString());
                                print(tripDetails);
                                  print(tripProgramme);
                                    print(numberOfDays.toString());
                                      print(dateController.text);
                                            print(selectedFeature);
                                BlocProvider.of<AddTripCubit>(context)
                                .AddTripinfo(tripName: tripname!,
                                  price: price!,
                                    destination:destination!, 
                                    required_age: requiredAge!,
                                      number_of_days: numberOfDays!,
                                    max_number_of_people: maxNumberOfPeople!,
                                      trip_details:tripDetails!,
                                        trip_programme: tripProgramme!,
                                          service: selectedFeature!,
                                          departure_day: dateController.text,);
          
            BlocProvider.of<TripCubit>(context).showAllTrip();
            //  Navigator.pop(context);
                      },
                      child: Text('Create Trip'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
