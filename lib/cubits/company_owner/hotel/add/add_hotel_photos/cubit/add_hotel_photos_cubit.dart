// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image/image.dart' as img;
// import 'package:bloc/bloc.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker_view/multi_image_picker_view.dart';

// import 'package:reserva/constants.dart';
// import 'package:path/path.dart' as path;
// import 'package:reserva/cubits/company_owner/hotel/add/add_hotel_photos/cubit/add_hotel_photos_state.dart';
// import 'package:reserva/helper/api.dart';

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_hotel_photos/cubit/add_hotel_photos_state.dart';
import 'package:reserva/helper/api.dart';

class AddHotelPhotosCubit extends Cubit<AddHotelPhotosState> {
  AddHotelPhotosCubit() : super(AddHotelPhotosInitial());
  // Future<void> AddHotelPhotos({
  //   required int hotel_id,
  //   required Iterable<ImageFile> photo,
  // }) async {
  //   emit(AddHotelPhotosLoading());
  //   try {
  //     print("before api request!!");

  //     String base_url = Api().base_url;
  //     final data = await Api().post(
  //         url: "$base_url/addHotelPhotos",
  //         body: {
  //           'hotel_id': hotel_id,
  //           'photo': photo,
  //         },
  //         // content: 'application/json',
  //         token: prefs!.getString("token"));
  //     print("token");
  //     inspect(data);
  //     print("after api request!!");
  //     print(data.body.toString());

  //     if (data.statusCode == 200) {
  //       emit(AddHotelPhotosSuccess(message: jsonDecode(data.body)["message"]));
  //     } else if (data.statusCode == 422) {
  //       emit(AddHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
  //     } else {
  //       emit(AddHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     emit(AddHotelPhotosFailure(message: "there is something wrong.."));
  //   }
  // }

  // Future<void> AddHotelPhotos({
  //   required int hotel_id,
  //   required Iterable<ImageFile> photos,
  // }) async {
  //   emit(AddHotelPhotosLoading());
  //   try {
  //     print("before api request!!");
  //     String base_url = Api().base_url;
  //     final request =
  //         http.MultipartRequest('POST', Uri.parse('$base_url/addHotelPhotos'));
  //     request.fields['hotel_id'] = hotel_id.toString();
  //     for (final photo in photos) {
  //       final file = await http.MultipartFile.fromBytes(
  //         'photo[]',
  //         photo.bytes!,
  //         filename: photo.name,
  //       );
  //       request.files.add(file);
  //     }
  //     request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';
  //     final response = await request.send();
  //     final data = await http.Response.fromStream(response);
  //     print("after api request!!");
  //     print(data.body.toString());
  //     if (data.statusCode == 200) {
  //       emit(AddHotelPhotosSuccess(message: jsonDecode(data.body)["message"]));
  //     } else if (data.statusCode == 422) {
  //       emit(AddHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
  //     } else {
  //       emit(AddHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     emit(AddHotelPhotosFailure(message: "there is something wrong.."));
  //   }
  // }
  /* Future<void> AddHotelPhotos({
    required int hotel_id,
    required Iterable<ImageFile> photos,
  }) async {
    emit(AddHotelPhotosLoading());
    try {
      print("before api request!!");

      final url = Uri.parse('${Api().base_url}/addHotelPhotos');
      final request = http.MultipartRequest('POST', url);
      request.fields['hotel_id'] = hotel_id.toString();

      for (final photo in photos) {
        final file = await http.MultipartFile.fromBytes(
          'photo[]',
          photo.bytes!,
          filename: photo.name,
        );
        request.files.add(file);
      }

      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';
      print("before api request!!");
      print("Request URL: $url");
      print("Request Headers: ${request.headers}");
      print("Request Body: ${request.fields} ${request.files}");
      final streamedResponse = await request.send();
      print("Response Status Code: ${streamedResponse.statusCode}");
      final response = await http.Response.fromStream(streamedResponse);
      print("Response Body: ${response.body}");
      print("after api request!!");
      print(response.body.toString());

      if (response.statusCode == 200) {
        emit(AddHotelPhotosSuccess(
            message: jsonDecode(response.body)["message"]));
      } else if (response.statusCode == 422) {
        emit(AddHotelPhotosFailure(
            message: jsonDecode(response.body)["message"]));
      } else {
        emit(AddHotelPhotosFailure(
            message: jsonDecode(response.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddHotelPhotosFailure(message: "there is something wrong.."));
    }
  }*/
  /*Future<void> AddHotelPhotos({
    required int hotel_id,
    required Iterable<ImageFile> photos,
  }) async {
    emit(AddHotelPhotosLoading());

    try {
      // Check if photos is not null and not empty
      if (photos != null || photos!.isEmpty) {
        print(photos);
        emit(AddHotelPhotosFailure(message: "Photos cannot be null or empty."));
        return;
      }
      print("before api request!!");

      final url = Uri.parse('${Api().base_url}/addHotelPhotos');
      final request = http.MultipartRequest('POST', url);
      request.fields['hotel_id'] = hotel_id.toString();

      for (final photo in photos) {
        final file = await http.MultipartFile.fromBytes(
          'photo[]',
          photo.bytes!,
          filename: photo.name,
        );
        request.files.add(file);
      }

      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

      print("Request URL: $url");
      print("Request Headers: ${request.headers}");
      print("Request Body: ${request.fields} ${request.files}");

      final streamedResponse = await request.send();
      print("Response Status Code: ${streamedResponse.statusCode}");
      final response = await http.Response.fromStream(streamedResponse);
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        emit(AddHotelPhotosSuccess(
            message: jsonDecode(response.body)["message"]));
      } else if (response.statusCode == 422) {
        emit(AddHotelPhotosFailure(
            message: jsonDecode(response.body)["message"]));
      } else {
        emit(AddHotelPhotosFailure(
            message: jsonDecode(response.body)["message"]));
      }
    } on Exception catch (e) {
      print("Error occurred before API request: $e");
      emit(AddHotelPhotosFailure(
          message: "There was an error before the API request."));
    } catch (e) {
      print("Unexpected error occurred before API request: $e");
      emit(AddHotelPhotosFailure(
          message: "An unexpected error occurred before the API request."));
    }
  }*/
  //lasttttttttttt
//   Future<void> AddHotelPhotos({
//     required int hotel_id,
//     required Iterable<ImageFile> photos,
//   }) async {
//     emit(AddHotelPhotosLoading());
//     try {
//       print("before api request!!");
//       final url = Uri.parse('${Api().base_url}/addHotelPhotos');
//       final request = http.MultipartRequest('POST', url);
//       request.fields['hotel_id'] = hotel_id.toString();
//       for (final photo in photos) {
//         print(photos);
//         if (photo.bytes != null) {
//           final file = await http.MultipartFile.fromBytes(
//             'photo[]',
//             photo.bytes!,
//             filename: photo.name,
//           );
//           request.files.add(file);
//         } else {
//           // Handle the case where the bytes property is null
//           print("The bytes property of the photo is null: ${photo.name}");
//           // You can either skip this photo or handle it in some other way
//         }
//       }
//       request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';
//       print("Request URL: $url");
//       print("Request Headers: ${request.headers}");
//       print("Request Body: ${request.fields} ${request.files}");
//       final streamedResponse = await request.send();
//       print("Response Status Code: ${streamedResponse.statusCode}");
//       final response = await http.Response.fromStream(streamedResponse);
//       print("Response Body: ${response.body}");
//       if (response.statusCode == 200) {
//         emit(AddHotelPhotosSuccess(
//             message: jsonDecode(response.body)["message"]));
//       } else if (response.statusCode == 422) {
//         emit(AddHotelPhotosFailure(
//             message: jsonDecode(response.body)["message"]));
//       } else {
//         emit(AddHotelPhotosFailure(
//             message: jsonDecode(response.body)["message"]));
//       }
//     } on Exception catch (e) {
//       print("Error occurred before API request: $e");
//       emit(AddHotelPhotosFailure(
//           message: "There was an error before the API request."));
//     } catch (e) {
//       print("Unexpected error occurred before API request: $e");
//       emit(AddHotelPhotosFailure(
//           message: "An unexpected error occurred before the API request."));
//     }
//   }
// }

  /* Future<void> AddHotelPhotos({
    required int hotel_id,
    required List<ImageFile> photos,
  }) async {
    emit(AddHotelPhotosLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      var request =
          http.MultipartRequest('POST', Uri.parse('$base_url/addHotelPhotos'));
      request.fields['hotel_id'] = hotel_id.toString();

      for (var photo in photos) {
        request.files
            .add(await http.MultipartFile.fromPath('photo[]', photo.path!));
      }

      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

      var response = await request.send();
      var data = await http.Response.fromStream(response);

      print("after api request!!");
      print(data.body.toString());

      if (response.statusCode == 200) {
        emit(AddHotelPhotosSuccess(message: jsonDecode(data.body)["message"]));
      } else if (response.statusCode == 422) {
        emit(AddHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
      } else {
        emit(AddHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddHotelPhotosFailure(message: "there is something wrong.."));
    }
  }
}*/
  /* Future<void> AddHotelPhotos({
    required int hotel_id,
    required Iterable<ImageFile> photos,
  }) async {
    emit(AddHotelPhotosLoading());

    try {
      print("before api request!!");

      final url = Uri.parse('${Api().base_url}/addHotelPhotos');
      final request = http.MultipartRequest('POST', url);
      request.fields['hotel_id'] = hotel_id.toString();

      for (final photo in photos) {
        if (photo.bytes != null) {
          final file = await http.MultipartFile.fromBytes(
            'photo[]',
            photo.bytes!,
            filename: photo.name,
          );
          request.files.add(file);
        } else {
          // Create a placeholder file
          final placeholderFile = await http.MultipartFile.fromBytes(
            'photo[]',
            [0], // Empty byte array
            filename: 'placeholder.png',
          );
          request.files.add(placeholderFile);
        }
      }

      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

      print("Request URL: $url");
      print("Request Headers: ${request.headers}");
      print("Request Body: ${request.fields} ${request.files}");

      final streamedResponse = await request.send();
      print("Response Status Code: ${streamedResponse.statusCode}");
      final response = await http.Response.fromStream(streamedResponse);
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        emit(AddHotelPhotosSuccess(
            message: jsonDecode(response.body)["message"]));
      } else if (response.statusCode == 422) {
        emit(AddHotelPhotosFailure(
            message: jsonDecode(response.body)["message"]));
      } else {
        emit(AddHotelPhotosFailure(
            message: jsonDecode(response.body)["message"]));
      }
    } on Exception catch (e) {
      print("Error occurred before API request: $e");
      emit(AddHotelPhotosFailure(
          message: "There was an error before the API request."));
    } catch (e) {
      print("Unexpected error occurred before API request: $e");
      emit(AddHotelPhotosFailure(
          message: "An unexpected error occurred before the API request."));
    }
  }*/

  // Future<void> AddHotelPhotos({
  //   required int hotel_id,
  //   required Iterable<ImageFile> photos,
  // }) async {
  //   final url = Uri.parse('http://127.0.0.1:8000/api/addHotelPhotos');
  //   final request = http.MultipartRequest('POST', url)
  //     ..fields['hotel_id'] = hotel_id.toString()
  //     ..headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

  //   for (final photo in photos) {
  //     if (photo.bytes != null) {
  //       emit(AddHotelPhotosLoading());
  //       try {
  //         // Decode the image data to check the file type
  //         final decodedImage = img.decodeImage(photo.bytes!);
  //         if (decodedImage != null) {
  //           final file = await http.MultipartFile.fromBytes(
  //             'photo[]',
  //             photo.bytes!,
  //             filename: photo.name,
  //           );
  //           request.files.add(file);
  //         } else {
  //           print("The photo '${photo.name}' is not a valid image file.");
  //           emit(AddHotelPhotosFailure(
  //               message:
  //                   "The photo '${photo.name}' is not a valid image file."));
  //         }
  //       } catch (e) {
  //         print("Error decoding the photo '${photo.name}': $e");
  //         emit(AddHotelPhotosFailure(
  //             message: "Error decoding the photo '${photo.name}': $e"));
  //       }
  //     } else {
  //       // Create a placeholder file
  //       final placeholderFile = await http.MultipartFile.fromBytes(
  //         'photo[]',
  //         [0],
  //         filename: 'placeholder.png',
  //       );
  //       request.files.add(placeholderFile);
  //     }
  //   }

  //   final response = await request.send();
  //   final responseBody = await response.stream.bytesToString();

  //   if (response.statusCode == 200) {
  //     // Handle successful response
  //     print('Hotel photos added successfully');
  //     emit(AddHotelPhotosSuccess(message: jsonDecode(responseBody)["message"]));
  //   } else {
  //     emit(AddHotelPhotosFailure(message: jsonDecode(responseBody)["message"]));
  //     print('Error adding hotel photos: $responseBody');
  //   }
  // }
  /* Future<void> AddHotelPhotos({
    required int hotel_id,
    required Iterable<ImageFile> photos,
  }) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/addHotelPhotos');
    final request = http.MultipartRequest('POST', url)
      ..fields['hotel_id'] = hotel_id.toString()
      ..headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';
    emit(AddHotelPhotosLoading());
    for (int i = 0; i < photos.length; i++) {
      final photo = photos.elementAt(i);
      if (photo.bytes != null) {
        try {
          // Decode the image data to check the file type
          final decodedImage = img.decodeImage(photo.bytes!);
          if (decodedImage != null) {
            final file = await http.MultipartFile.fromBytes(
              'photo[$i]',
              photo.bytes!,
              filename: photo.name,
            );
            request.files.add(file);
          } else {
            print("The photo '${photo.name}' is not a valid image file.");
            emit(AddHotelPhotosFailure(
                message:
                    "The photo '${photo.name}' is not a valid image file."));
          }
        } catch (e) {
          print("Error decoding the photo '${photo.name}': $e");
          emit(AddHotelPhotosFailure(
              message: "Error decoding the photo '${photo.name}': $e"));
        }
      } else {
        // Create a placeholder file
        final placeholderFile = await http.MultipartFile.fromBytes(
          'photo[$i]',
          [0],
          filename: 'placeholder.png',
        );
        request.files.add(placeholderFile);
      }
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // Handle successful response
      print('Hotel photos added successfully');
      emit(AddHotelPhotosSuccess(message: jsonDecode(responseBody)["message"]));
    } else {
      emit(AddHotelPhotosFailure(message: jsonDecode(responseBody)["message"]));
      print('Error adding hotel photos: $responseBody');
    }
  }*/

  File? selectedImage;
  var fileBytes;

  Future<void> AddHotelPhoto(

      //required Uint8List fileBytes, // Add this parameter to receive the image data
      ) async {
    emit(AddHotelPhotosLoading());
    try {
      // Create a new multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Api().base_url}/addHotelPhotos'),
      );

      // Add the image file
      request.files.add(http.MultipartFile.fromBytes(
        'photo[]',
        fileBytes,
        filename: 'photo.jpg',
      ));

      // Set the authorization token
      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

      // Send the request and wait for the response
      final response = await request.send();

      // Read the response body
      final data = await response.stream.bytesToString();

      // Parse the response
      final data_map = jsonDecode(data);

      if (response.statusCode == 200) {
        emit(AddHotelPhotosSuccess(message: 'success'));
      } else if (response.statusCode == 422) {
        print('4222');
        emit(AddHotelPhotosFailure(message: data_map['message']));
      } else {
        print('!!!!!!!!');
        emit(AddHotelPhotosFailure(message: data_map["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddHotelPhotosFailure(message: "there is something wrong.."));
    }
  }

  void pickImage() {
    XFile? pickedFile;
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      pickedFile = value;
      if (pickedFile != null) {
        print("selected image success!!!!");
        selectedImage = File(pickedFile!.path);
        emit(AddHotelPhotosSuccess(message: 'select success'));
      }
    });
  }

  /* List<File>? selectedImages;

  Future<void> AddHotelPhoto({
    required int hotel_id,
    required List<File> images,
  }) async {
    emit(AddHotelPhotosLoading());
    try {
      // Create a new multipart request
      print('before apiiiii');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Api().base_url}/addHotelPhotos'),
      );
      print('after apiiiiiii');
      // Add the form fields
      request.fields.addAll({
        'hotel_id': hotel_id.toString(),
      });
      print('afterrrr hotel id');
      // Add the image files
      for (final image in images) {
        request.files.add(http.MultipartFile.fromBytes(
          'photo[]',
          await image.readAsBytes(),
          filename: path.basename(image.path),
        ));
      }
      print('afer forrrrrrrrr');
      // Set the authorization token
      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

      // Send the request and wait for the response
      final response = await request.send();

      // Read the response body
      final data = await response.stream.bytesToString();

      // Parse the response
      final data_map = jsonDecode(data);

      if (response.statusCode == 200) {
        emit(AddHotelPhotosSuccess(message: 'success'));
      } else if (response.statusCode == 422) {
        emit(AddHotelPhotosFailure(message: data_map['message']));
      } else {
        emit(AddHotelPhotosFailure(message: data_map["message"]));
      }
    } on Exception catch (e) {
      emit(AddHotelPhotosFailure(message: "there is something wrong.."));
    }
  }

  void pickImages() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    print('befire iffffffff');
    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      selectedImages =
          pickedFiles.files.map((file) => File(file.path!)).toList();
      emit(AddHotelPhotosSuccess(message: 'select success'));
    } else {
      print('errrrror');
    }
  }*/
}
