import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_room/cubit/edit_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_room/cubit/edit_room_state.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/models/room_features.dart';
import 'package:reserva/widgets/company_owner/hotels/feature_drop_down.dart';
import 'package:reserva/widgets/company_owner/hotels/type_drop_down.dart';
import 'package:reserva/widgets/shared/drop_down_list.dart';
import 'package:reserva/widgets/shared/picker.dart';

class EditRoom extends StatelessWidget {
  EditRoom({super.key, required this.data});
  final Room data;

  // final controller = MultiImagePickerController(
  //     maxImages: 10,
  //     picker: (allowMultiple) async {
  //       return await pickImagesUsingImagePicker(allowMultiple);
  //     });

  FilePickerResult? result;

  TextEditingController _imageController = TextEditingController();

  File? image;

  final _formKey = GlobalKey<FormState>();

  String? details;

  String? beds;

  String? sleeps;

  String? price;

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

  List<RoomFeatures>? features = [
    // RoomFeatures(id: 1, name: 'sound proof'),
    // RoomFeatures(id: 2, name: 'safty'),
    // RoomFeatures(id: 3, name: 'water services'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditRoomCubit, EditRoomState>(
        listener: (context, state) {
      if (state is EditRoomFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is EditRoomSuccess) {
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
      if (state is EditRoomLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView(children: [
        Container(
          child: AlertDialog(
            title: Text(
              'Edit a Room',
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
                      initialValue: data.details,
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
                      onChanged: (value) {
                        details = value;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            initialValue: data.beds.toString(),
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
                            onChanged: (value) {
                              beds = value;
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            initialValue: data.sleeps.toString(),
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
                            onChanged: (value) {
                              sleeps = value;
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
                          width: 170,
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
                            hint: data.roomType.roomType,
                            isdropSelected: true,
                            dataList: BlocProvider.of<EditRoomCubit>(context)
                                .roomTypes,
                            selectedValue: selectedType,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: 330,
                            child: RoomFeaturesDropDown(
                              onChanged: (value) {
                                selectedFeature =
                                    value?.split(',').toList() ?? [];
                              },
                              // onTap: () {
                              //   BlocProvider.of<AddMedicineCubit>(context)
                              //       .getFilters();
                              // },
                              // textEditingController: category,
                              title: 'Feautures',
                              hint: _getFeatureNamesAsString(data.roomFeatures),
                              //  data.roomFeatures[0].featureName +
                              //     data.roomFeatures[1].featureName +
                              //     data.roomFeatures[2].featureName +
                              //     data.roomFeatures[3].featureName,
                              isdropSelected: true,
                              dataList: BlocProvider.of<EditRoomCubit>(context)
                                  .features,
                              selectedValues: selectedFeature,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 400,
                      height: 200,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              //initialValue: data.roomPhotos[0],
                              controller: _imageController,
                              decoration: InputDecoration(
                                  labelText: 'Image Path and Name',
                                  hintText: data.roomPhotos[0]),
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
                                    BlocProvider.of<EditRoomCubit>(context)
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
                    /* Expanded(
                              child: Container(
                            width: 300,
                            height: 100,
                            child: Flexible(
                              child: MultiImagePickerView(
                                controller: controller,
                                padding: const EdgeInsets.all(10),
                              ),
                            ),
                          )),*/
                    // Expanded(
                    //   child: Container(
                    //     width: 400,
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //           child: TextFormField(
                    //             controller: _imageController,
                    //             decoration: InputDecoration(
                    //               labelText: 'Image Path and Name',
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           child: ElevatedButton(
                    //             onPressed: () async {
                    //               result = await FilePicker.platform.pickFiles(
                    //                 type: FileType.image,
                    //               );

                    //               if (result != null) {
                    //                 PlatformFile file = result!.files.first;
                    //                 String imageName = file.name;

                    //                 _imageController.text = imageName;

                    //                 // User has selected an image
                    //                 final fileBytes = result!.files.single.bytes;

                    //                 if (fileBytes != null) {
                    //                   // Image bytes are available
                    //                 }
                    //               }
                    //             },
                    //             child: Text(
                    //               'Select Image',
                    //               style: TextStyle(color: Colors.blue),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Container(
                        width: 200,
                        child: TextFormField(
                          initialValue: data.priceForNight,
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
                          onChanged: (value) {
                            price = value;
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
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<EditRoomCubit>(context).EditRoom(
                            room_type_id: selectedType == null
                                ? data.roomType.id.toString()
                                : selectedType!,
                            sleeps: sleeps == null
                                ? data.sleeps.toString()
                                : sleeps!,
                            beds: beds == null ? data.beds.toString() : beds!,
                            details: details == null
                                ? data.details.toString()
                                : details!,
                            price_for_night: price == null
                                ? data.priceForNight.toString()
                                : price!,
                            features: selectedFeature!,
                            id: data.id);
                        BlocProvider.of<ShowRoomCubit>(context)
                            .showHotelRooms();
                        /*  Navigator.pushNamed(
                      context,
                      'Category',
                    );*/
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

String _getFeatureNamesAsString(List<Feature> features) {
  return features
      .map((feature) => feature.featureName)
      .take(4) // Limit to the first 4 features
      .join(', ');
}
