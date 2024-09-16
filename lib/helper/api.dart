import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:reserva/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<void> _saveUserData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //var token = prefs.get('token');
  }

  String base_url = "http://127.0.0.1:8000/api";

  Future<http.Response> get(
      {required String url, @required String? token}) async {
    print('inside api class');

    Map<String, String> headers = {'Accept': 'application/json'};
    // if (token != null) {
    headers.addAll({"Authorization": "Bearer ${prefs!.getString("token")}"});
    // }
    print("this is the headers ${headers}");

    print("url=$url  token=$token");
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    print(response);
    inspect(response);
    return response;
  }

  Future<http.Response> post(
      {required String url,
      @required dynamic body,
      @required String? token,
      @required String? content}) async {
    // var token = prefs?.get('token');
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    if (token != null) {
      print('danaaaa');
      headers.addAll({"Authorization": "Bearer ${prefs!.getString("token")}"});
      print('hiiiiiiiiiiiiii');
    }
    if (content != null) {
      print('danaaaa');
      headers.addAll({"Content-Type": content});
      print('contetnttttt');
    }
    print('beforeeeeee');
    print("url=$url body=$body token=$token");
    print('afterrrrrrrr');

    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    print(response);
    inspect(response);
    print('finalllllllllll');
    return response;
  }

  Future<http.Response> postImage({
    required String url,
    required dynamic body,
    String? token,
    String? contentType,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }

    http.Response response = await http.post(
      Uri.parse(url),
      body: body is Map ? json.encode(body) : body,
      headers: headers,
    );

    return response;
  }

  Future<http.StreamedResponse> postWithImage({
    required String url,
    required Map<String, dynamic> body,
    File? file,
    String? token,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({"Accept": "application/json"});
    if (token != null) {
      request.headers.addAll({"Authorization": "Bearer $token"});
    }
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    if (file != null) {
      final fileName = file.path.split('/').last;
      final fileType = fileName.split('.').last;
      print(fileType);
      if (fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg') {
        // final multipartFile = http.MultipartFile.fromPath(
        //   'image', file.path
        //   // fileStream,
        //   // fileLength,
        //   // filename: fileName,
        // );
        request.files.add(await http.MultipartFile.fromPath('image', file.path
            // fileStream,
            // fileLength,
            // filename: fileName,
            ));
      } else {
        throw Exception(
            'Invalid file type. Please select a PNG, JPG, or JPEG image.');
      }
    }
    final response = await request.send();
    // final responseString = await response.stream.bytesToString();
    // final data = jsonDecode(responseString);
    return response;
  }

  Future<http.Response> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs!.getString('token');
    Map<String, String> headers = {'Accept': 'application/json'};

    //if (token != null) {
    headers.addAll({"Authorization": "Bearer $token"});
    //}
    print("url=$url body=$body token=$token");
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    return response;
  }

  Future<dynamic> delete(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    print("start api");
    var token = prefs!.getString('token');
    Map<String, String> headers = {'Accept': 'application/json'};

    headers.addAll({"Authorization": "Bearer $token"});

    print("url=$url body=$body token=$token");
    http.Response response =
        await http.delete(Uri.parse(url), body: body, headers: headers);
    return response;
  }
}

class ValidationException implements Exception {
  Map<String, List<dynamic>> errors;
  ValidationException({required this.errors});
}

class FailureException implements Exception {
  String message;
  FailureException({required this.message});
}



// import 'package:flutter/material.dart';
// import 'api_service.dart';

// class AddFlightPage extends StatefulWidget {
//   @override
//   _AddFlightPageState createState() => _AddFlightPageState();
// }

// class _AddFlightPageState extends State<AddFlightPage> {
//   final ApiService _apiService = ApiService();

//   int? _fromCityId;
//   int? _toCityId;
//   String _economySeat = '';
//   String _firstClassSeat = '';
//   String _businessSeat = '';
//   bool _checkedBag = false;
//   bool _handBag = false;
//   int _seatsNumber = 0;

//   final List<Map<String, dynamic>> _cities = [
//     {'id': 1, 'name': 'City A'},
//     {'id': 2, 'name': 'City B'},
//     {'id': 3, 'name': 'City C'},
//   ];

//   void _onCityChanged(String cityType, int cityId) {
//     setState(() {
//       if (cityType == 'from') {
//         _fromCityId = cityId;
//       } else if (cityType == 'to') {
//         _toCityId = cityId;
//       }
//     });
//   }

//   void _onSeatChanged(String flightClass, String seat) {
//     setState(() {
//       switch (flightClass) {
//         case 'Economy':
//           _economySeat = seat;
//           break;
//         case 'First Class':
//           _firstClassSeat = seat;
//           break;
//         case 'Business':
//           _businessSeat = seat;
//           break;
//       }
//     });
//   }

//   void _onCheckedBagChanged(bool? value) {
//     setState(() {
//       _checkedBag = value ?? false;
//     });
//   }

//   void _onHandBagChanged(bool? value) {
//     setState(() {
//       _handBag = value ?? false;
//     });
//   }

//   void _onSeatsNumberChanged(String value) {
//     setState(() {
//       _seatsNumber = int.tryParse(value) ?? 0;
//     });
//   }

// void _addFlight() async {
//   if (_fromCityId == null  _toCityId == null  _seatsNumber == 0) {
//     print('Please fill all required fields');
//     return;
//   }

//   Map<String, dynamic> flightData = {
//     'from_city_id': _fromCityId,
//     'to_city_id': _toCityId,
//     'checked_bag': _checkedBag,
//     'hand_bag': _handBag,
//     'seats_num': _seatsNumber,
//   };

//   if (_economySeat.isNotEmpty) {
//     flightData['classes'] = {
//       'economy': {
//         'flight_class_id': 1, // Example economy class id
//         'seat_selection': _economySeat,
//       }
//     };
//   }

//   if (_firstClassSeat.isNotEmpty) {
//     flightData['classes'] ??= {}; // Initialize classes if not yet
//     flightData['classes']['first_class'] = {
//       'flight_class_id': 2, // Example first class id
//       'seat_selection': _firstClassSeat,
//     };
//   }

//   if (_businessSeat.isNotEmpty) {
//     flightData['classes'] ??= {}; // Initialize classes if not yet
//     flightData['classes']['business'] = {
//       'flight_class_id': 3, // Example business class id
//       'seat_selection': _businessSeat,
//     };
//   }

//   try {
//     final response = await _apiService.addFlight(flightData);
//     if (response['status'] == 1) {
//       print('Flight added successfully');
//     } else {
//       print('Failed to add flight: ${response['message']}');
//     }
//   } catch (error) {
//     print('Error adding flight: $error');
//   }
// }



// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Flight'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: <Widget>[
//             DropdownButtonFormField<int>(
//               decoration: InputDecoration(labelText: 'From City'),
//               items: _cities.map((city) {
//                 return DropdownMenuItem<int>(
//                   value: city['id'],
//                   child: Text(city['name']),
//                 );
//               }).toList(),
//               onChanged: (int? newValue) {
//                 _onCityChanged('from', newValue!);
//               },
//             ),
//             SizedBox(height: 16),
//             DropdownButtonFormField<int>(
//               decoration: InputDecoration(labelText: 'To City'),
//               items: _cities.map((city) {
//                 return DropdownMenuItem<int>(
//                   value: city['id'],
//                   child: Text(city['name']),
//                 );
//               }).toList(),
//               onChanged: (int? newValue) {
//                 _onCityChanged('to', newValue!);
//               },
//             ),
//             SizedBox(height: 16),
//             Text('Economy Class'),
//             TextField(
//               decoration: InputDecoration(labelText: 'Seat Selection'),
//               keyboardType: TextInputType.number,
//               onChanged: (value) => _onSeatChanged('Economy', value),
//             ),
//             SizedBox(height: 16),
//             Text('First Class'),
//             TextField(
//               decoration: InputDecoration(labelText: 'Seat Selection'),
//               keyboardType: TextInputType.number,
//               onChanged: (value) => _onSeatChanged('First Class', value),
//             ),
//             SizedBox(height: 16),
//             Text('Business Class'),
//             TextField(
//               decoration: InputDecoration(labelText: 'Seat Selection'),
//               keyboardType: TextInputType.number,
//               onChanged: (value) => _onSeatChanged('Business', value),
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: <Widget>[
//                 Checkbox(
//                   value: _checkedBag,
//                   onChanged: _onCheckedBagChanged,
//                 ),
//                 Text('Checked Bag'),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Checkbox(
//                   value: _handBag,
//                   onChanged: _onHandBagChanged,
//                 ),
//                 Text('Hand Bag'),
//               ],
//             ),
//             SizedBox(height: 16),
//             TextField(
//               decoration: InputDecoration(labelText: 'Seats Number'),
//               keyboardType: TextInputType.number,
//               onChanged: _onSeatsNumberChanged,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addFlight,
//               child: Text('Add Flight'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
