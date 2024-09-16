// ignore_for_file: unnecessary_import, camel_case_types, prefer_const_constructors, must_be_immutable, unnecessary_null_comparison



import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserva/cubits/admin/Add_Attraction/add_attraction_cubit.dart';
import 'package:reserva/cubits/admin/Attraction/attraction_cubit.dart';
import 'package:reserva/widgets/admin/Attraction/DropDowenType.dart';
import 'package:reserva/widgets/admin/Attraction/DropDowenCity.dart';
import 'package:reserva/widgets/admin/time_picker.dart';

class Add_Attraction extends StatelessWidget {
  Add_Attraction({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  FilePickerResult? result;

  TextEditingController _imageController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final textFieldKey = GlobalKey();
  // List<XFile> selectedImages = [];
  String? name;
  String? description;
  String? image;
  String? select_city;
  String? select_type;
  Widget build(BuildContext context) {
    return BlocConsumer<AddAttractionCubit, AddAttractionState>(
        listener: (context, state) {
      if (state is AddAttractionFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is AddAttractionSuccess) {
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
          BlocProvider.of<AttractionCubit>(context).fetchAttractions();
        Navigator.pop(context);
          BlocProvider.of<AttractionCubit>(context).fetchAttractions();
      }
    }, builder: (context, state) {
      if (state is AddAttractionLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Container(
        width: 100,
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
                  TextFormField(
                    controller: _nameController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: const Color(0xFF064061),
                      ),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the attraction name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: const Color(0xFF064061),
                      ),
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 300,
                    child: DropDownAttraction(
                      onChanged: (value) {
                        select_type = value;
                      },
                      title: 'Type',
                      hint: 'Select a Type',
                      isdropSelected: true,
                      dataList: BlocProvider.of<AddAttractionCubit>(context)
                          .attractionTypes,
                      selectedValue: select_type,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: DropDownCity(
                      onChanged: (value) {
                        select_city = value;
                      },
                      title: 'City',
                      hint: 'Select a city',
                      isdropSelected: true,
                      dataList:
                          BlocProvider.of<AddAttractionCubit>(context).cities,
                      selectedValue: select_city,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(BlocProvider.of<AddAttractionCubit>(context)
                                      .selectedTime1 !=
                                  null
                              ? "${BlocProvider.of<AddAttractionCubit>(context).selectedTime1.hour}:${BlocProvider.of<AddAttractionCubit>(context).selectedTime1.minute}"
                              : 'Select Time'),
                          Container(
                              child: CustomTimePicker(
                            initialTime:
                                BlocProvider.of<AddAttractionCubit>(context)
                                        .selectedTime1 ??
                                    TimeOfDay.now(),
                            onTimeSelected: (TimeOfDay time) {
                              BlocProvider.of<AddAttractionCubit>(context)
                                  .updateSelectedTime1(time);
                              // setState(() {
                              //   selectedTime = time;
                              // });
                            },
                            hourHandColor: Color(0xff90CAF9),
                            themeColor: Color(0xff90CAF9),
                            time: "open At",
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Text(BlocProvider.of<AddAttractionCubit>(context)
                                      .selectedTime2 !=
                                  null
                              ? "${BlocProvider.of<AddAttractionCubit>(context).selectedTime2.hour}:${BlocProvider.of<AddAttractionCubit>(context).selectedTime2.minute}"
                              : 'Select Time'),
                          Container(
                              child: CustomTimePicker(
                            initialTime:
                                BlocProvider.of<AddAttractionCubit>(context)
                                        .selectedTime2 ??
                                    TimeOfDay.now(),
                            onTimeSelected: (TimeOfDay time) {
                              BlocProvider.of<AddAttractionCubit>(context)
                                  .updateSelectedTime2(time);
                              // setState(() {
                              //   selectedTime = time;
                              // });
                            },
                            hourHandColor: Color(0xff90CAF9),
                            themeColor: Color(0xff90CAF9),
                            time: "Close At",
                          )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
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
                                BlocProvider.of<AddAttractionCubit>(context)
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
                    BlocProvider.of<AttractionCubit>(context).fetchAttractions();
                    Navigator.pop(context);
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
                    print(name);
                    print(description);
                    print(_imageController.text);
                    print(select_city);
                    print(select_type);
                    print(BlocProvider.of<AddAttractionCubit>(context)
                        .selectedTime2);
                    print(BlocProvider.of<AddAttractionCubit>(context)
                        .selectedTime1);

                    BlocProvider.of<AddAttractionCubit>(context)
                        .AddAttractioninfo(
                            attractionName: name!,
                            open_at:
                                BlocProvider.of<AddAttractionCubit>(context)
                                    .selectedTime1,
                            close_at:
                                BlocProvider.of<AddAttractionCubit>(context)
                                    .selectedTime2,
                            about: description!,
                            cityId: select_city!,
                            attractionTypeId: select_type!);
                              BlocProvider.of<AttractionCubit>(context).fetchAttractions();
                               Navigator.pop(context);
                              
                  
                  },
                  child: Text('Create Attraction'),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
