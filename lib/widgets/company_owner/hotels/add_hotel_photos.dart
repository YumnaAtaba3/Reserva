import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_hotel_photos/cubit/add_hotel_photos_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_hotel_photos/cubit/add_hotel_photos_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_hotel_photos/cubit/show_hotel_photos_cubit.dart';
import 'package:reserva/widgets/shared/picker.dart';

class AddPhotos extends StatelessWidget {
  FilePickerResult? result;
  TextEditingController _imageController = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();
//  final int hotel_id = prefs!.getInt('hotel_id')!;
  // final int? hotel_id = prefs!.getInt('hotel_id');
  final controller = MultiImagePickerController(
      maxImages: 10,
      picker: (allowMultiple) async {
        // return await pickImagesUsingImagePicker(allowMultiple);
        return pickImagesUsingImagePicker(allowMultiple);
      });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddHotelPhotosCubit, AddHotelPhotosState>(
      listener: (context, state) {
        if (state is AddHotelPhotosFailure) {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    content: Text(state.message.toString()),
                  )));
        }
        if (state is AddHotelPhotosSuccess) {
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
          BlocProvider.of<ShowHotelPhotosCubit>(context).showHotelPhotos();
        }
      },
      builder: (context, state) {
        if (state is AddHotelPhotosLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return AlertDialog(
          title: Text(
            'Add Photos',
            style: TextStyle(
                color: Color(0xFF064061),
                fontFamily: "DancingScript",
                fontSize: 35,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content:
              // Container(
              //   width: 400,
              //   height: 200,
              //   child: Expanded(
              //     child: MultiImagePickerView(
              //       controller: controller,
              //       padding: const EdgeInsets.all(10),
              //     ),
              //   ),),
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
                          BlocProvider.of<AddHotelPhotosCubit>(context)
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
          //     Container(
          //   width: 400,
          //   height: 200,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: ElevatedButton(
          //           onPressed: () {
          //             BlocProvider.of<AddHotelPhotosCubit>(context)
          //                 .pickImages();
          //           },
          //           child: Text('Select Images'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          /*  Row(
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
                    BlocProvider.of<AddHotelPhotosCubit>(context)
                        .AddHotelPhoto();
                    BlocProvider.of<ShowHotelPhotosCubit>(context)
                        .showHotelPhotos();
                    /*final images = BlocProvider.of<AddHotelPhotosCubit>(context)
                        .selectedImages;
                    print(images);
                    if (images != null && images.isNotEmpty) {
                      BlocProvider.of<AddHotelPhotosCubit>(context)
                          .AddHotelPhoto(hotel_id: hotel_id, images: images);
                    }*/

                    // if (_formKey.currentState!.validate()) {
                    //   _formKey.currentState!.save();

                    //   Navigator.pop(context);
                    // }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(color: Color(0xFF064061)),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
