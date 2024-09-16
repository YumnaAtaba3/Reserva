
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserva/cubits/admin/Add_Attraction/add_attraction_cubit.dart';
import 'package:reserva/cubits/admin/Attraction/attraction_cubit.dart';
import 'package:reserva/cubits/admin/editAttraction/edit_attraction_cubit.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/widgets/admin/Attraction/DropDowenType.dart';
import 'package:reserva/widgets/admin/Attraction/DropDowenCity.dart';
import 'package:reserva/widgets/admin/time_picker.dart';

class EditAttraction extends StatelessWidget {
  EditAttraction({super.key, required this.data});
  final Attraction data;

  final _formKey = GlobalKey<FormState>();
  FilePickerResult? result;

  TextEditingController _imageController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final textFieldKey = GlobalKey();
  // List<XFile> selectedImages = [];

  String? description;
  String? image;
  String? select_city;

  Widget build(BuildContext context) {
    return BlocConsumer<EditAttractionCubit,EditAttractionState>(
        listener: (context, state) {
      if (state is EditAttractionFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is EditAttractionSuccess) {
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
      if (state is EditAttractionLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Container(
        width: 100,
        child: AlertDialog(
          title: Text(
            'Edit your information:',
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
                    initialValue: data.about,
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
                     onSaved: (value) {
                          description = value!;
                        },
                    onChanged: (value) {
                      description = value;
                    },
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
                      hint: data.city.cityName
                      ,
                      isdropSelected: true,
                      dataList:
                          BlocProvider.of<EditAttractionCubit>(context).cities,
                      selectedValue: select_city,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(BlocProvider.of<EditAttractionCubit>(context)
                                      .selectedTime1 !=
                                  null
                              ? "${BlocProvider.of<EditAttractionCubit>(context).selectedTime1.hour}:${BlocProvider.of<EditAttractionCubit>(context).selectedTime1.minute}"
                              : 'Select Time'),
                          Container(
                              child: CustomTimePicker(
                            initialTime:
                                BlocProvider.of<EditAttractionCubit>(context)
                                        .selectedTime1 ??
                                    TimeOfDay.now(),
                            onTimeSelected: (TimeOfDay time) {
                              BlocProvider.of<EditAttractionCubit>(context)
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
                          Text(BlocProvider.of<EditAttractionCubit>(context)
                                      .selectedTime2 !=
                                  null
                              ? "${BlocProvider.of<AddAttractionCubit>(context).selectedTime2.hour}:${BlocProvider.of<EditAttractionCubit>(context).selectedTime2.minute}"
                              : 'Select Time'),
                          Container(
                              child: CustomTimePicker(
                            initialTime:
                                BlocProvider.of<EditAttractionCubit>(context)
                                        .selectedTime2 ??
                                    TimeOfDay.now(),
                            onTimeSelected: (TimeOfDay time) {
                              BlocProvider.of<EditAttractionCubit>(context)
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
                    Container(
                      width: 400,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              //initialValue: data.roomPhotos[0],
                              controller: _imageController,
                              decoration: InputDecoration(
                                  labelText: 'Image Path and Name',
                                  hintText: data.attractionPhoto),
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
                                    BlocProvider.of<EditAttractionCubit>(context)
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
                      if (_formKey.currentState!.validate()) {
                    print(description);
                   // print(Controller.text);
                    print(select_city);
                    
                    print(BlocProvider.of<EditAttractionCubit>(context)
                        .selectedTime2);
                    print(BlocProvider.of<EditAttractionCubit>(context)
                        .selectedTime1);

                    BlocProvider.of<EditAttractionCubit>(context)
                        .EditAttractioninfo(
                          id: data.id,
                            open_at:
                                BlocProvider.of<EditAttractionCubit>(context)
                                    .selectedTime1,
                            close_at:
                                BlocProvider.of<EditAttractionCubit>(context)
                                    .selectedTime2,
                            about: description==null?data.about:description!,
                            cityId:select_city == null
                                ? data.city.id.toString()
                                :select_city!,
                            
                            );
                              BlocProvider.of<AttractionCubit>(context).fetchAttractions();
                              Navigator.pop(context);
                              
                      }
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
