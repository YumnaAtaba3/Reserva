import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reserva/cubits/company_owner/hotel/add/add_room/cubit/add_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_room/cubit/add_room_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_cubit.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

import 'package:reserva/widgets/company_owner/hotels/feature_drop_down.dart';
import 'package:reserva/widgets/company_owner/hotels/type_drop_down.dart';

class AddRoom extends StatelessWidget {
  AddRoom({super.key});

  /*final controller = MultiImagePickerController(
      maxImages: 10,
      picker: (allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });*/

  FilePickerResult? result;
  //final int hotel_id = prefs!.getInt('hotel_id')!;
  TextEditingController _imageController = TextEditingController();
  TextEditingController _bedsController = TextEditingController();
  TextEditingController _sleepsController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  File? image;

  final _formKey = GlobalKey<FormState>();

  String _details = '';

  String _beds = '';

  String _sleeps = '';

  String _price = '';

  String? selectedType;

  List<String> selectedFeature = [];

  List<RoomType>? types = [
    // RoomType(id: 1, name: 'Deluxe twin room'),
    // RoomType(id: 2, name: 'Deluxe triple rrom'),
    // RoomType(id: 3, name: 'Single room'),
    // RoomType(id: 4, name: 'Connected rrom'),
    // RoomType(id: 5, name: 'Smoking room'),
    // RoomType(id: 6, name: 'Non Smoking room'),
  ];

  List<Feature>? features = [
    // RoomFeatures(id: 1, name: 'sound proof'),
    // RoomFeatures(id: 2, name: 'safty'),
    // RoomFeatures(id: 3, name: 'water services'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomCubit, AddRoomState>(listener: (context, state) {
      if (state is AddRoomFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is AddRoomSuccess) {
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
        BlocProvider.of<ShowRoomCubit>(context).showHotelRooms();
      }
    }, builder: (context, state) {
      if (state is AddRoomLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView(children: [
        Container(
          child: AlertDialog(
            title: Text(
              'Add a Room',
              style: TextStyle(
                  fontFamily: "DancingScript",
                  color: Color(0xFF064061),
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 560,
              width: 540,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _detailsController,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: 'Room Details:',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a room details';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _details = value!;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            controller: _bedsController,
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Beds:',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the number of beds';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _beds = value!;
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            controller: _sleepsController,
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Sleeps:',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the number of sleeps';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _sleeps = value!;
                            },
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
                          width: 180,
                          child: RoomTypeDropDown(
                            onChanged: (value) {
                              selectedType = value;
                            },
                            // onTap: () {
                            //   BlocProvider.of<AddMedicineCubit>(context)
                            //       .getFilters();
                            // },
                            // textEditingController: category,
                            title: 'Type',
                            hint: 'Select a Type',
                            isdropSelected: true,
                            dataList: BlocProvider.of<AddRoomCubit>(context)
                                .roomTypes,
                            selectedValue: selectedType,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 320,
                            child: RoomFeaturesDropDown(
                              onChanged: (value) {
                                selectedFeature =
                                    value?.split(',').toList() ?? [];
                                // selectedFeature = value as List<String>;
                              },
                              // onTap: () {
                              //   BlocProvider.of<AddMedicineCubit>(context)
                              //       .getFilters();
                              // },
                              // textEditingController: category,
                              title: 'Features',
                              hint: 'Select a feature',
                              isdropSelected: true,
                              dataList: BlocProvider.of<AddRoomCubit>(context)
                                  .features,
                              selectedValues: selectedFeature,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Expanded(
                    //   child: Container(
                    //     width: 300,
                    //     height: 100,
                    //     child: Flexible(
                    //       child: MultiImagePickerView(
                    //         controller: controller,
                    //         padding: const EdgeInsets.all(10),
                    //       ),
                    //     ),),),
                    Container(
                      width: 400,
                      height: 200,
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

                                  if (fileBytes != null) {
                                    // Image bytes are available
                                    BlocProvider.of<AddRoomCubit>(context)
                                        .fileBytes = fileBytes;
                                    // print(fileBytes);
                                  }
                                }
                              },
                              child: Text('Select Image'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /*Row(
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
      
                                  if (fileBytes != null) {
                                    // Image bytes are available
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
                      ),*/

                    Center(
                      child: Container(
                        width: 200,
                        child: TextFormField(
                          controller: _priceController,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Price:',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the price';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _price = value!;
                          },
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
                      print(selectedFeature);
                      BlocProvider.of<AddRoomCubit>(context).AddRoom(
                          room_type_id: selectedType!,
                          features: selectedFeature!,
                          // selectedFeature!.toInt(),
                          beds: _bedsController.text,
                          sleeps: _sleepsController.text,
                          details: _detailsController.text,
                          price_for_night: _priceController.text);
                      BlocProvider.of<ShowRoomCubit>(context).showHotelRooms();

                      // BlocProvider.of<ShowRoomCubit>(context)
                      //     .showHotelRooms();
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();

                      //   Navigator.pop(context);
                    },
                    child: Text('Create',
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
