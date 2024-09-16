// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:reserva/cubits/admin/AddTrip/add_trip_cubit.dart';
import 'package:reserva/cubits/admin/Attraction/attraction_cubit.dart';
import 'package:reserva/cubits/admin/EditTrip/edit_trip_cubit.dart';
import 'package:reserva/cubits/admin/Trip/trip_cubit.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/models/admin/trip.dart';
import 'package:reserva/pages/admin/Trip/EditTrip.dart';
import 'package:reserva/pages/admin/Trip/Trip_drawer.dart';
import 'package:reserva/widgets/admin/TripSearch/ShowdialogTrip.dart';


import 'package:reserva/pages/admin/Trip/Trip_details.dart';
import 'package:reserva/widgets/admin/TripSearch/Trip_search.dart';
import 'package:reserva/widgets/admin/time_picker.dart';
import 'package:reserva/widgets/admin/TripSearch/trip_silder.dart';

import 'package:reserva/widgets/shared/picker.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class TripsPage extends StatefulWidget {
  TripsPage({super.key});


  @override
  State<TripsPage> createState() => _TripsPageState();
}
  final ScrollController controllerr = ScrollController();
class _TripsPageState extends State<TripsPage> {
  
 final controller = MultiImagePickerController(
      maxImages: 10,
      picker: (allowMultiple) async {
        return await pickImagesUsingImagePicker(allowMultiple);
      });
  final ScrollController scrollController = ScrollController();
  List<Attraction> previousAttractions = [];
  double itemWidth = 400;
  double itemHeight = 300;
  FilePickerResult? result;
  TextEditingController _imageController = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final textFieldKey = GlobalKey();
  TimeOfDay selectedTime = TimeOfDay.now();
  final ImagePicker _imagePicker = ImagePicker();
  String? _departDay = '';
  List<String> selectedServices = [];
  List<String> selectedActivities = [];

  //List<String> services = ['Play', 'Wifi', 'Food','sport'];
  List<Map<String, dynamic>> services = [
  {"name": "Pillow", "selected": false},
  {"name": "Meals", "selected": false},
  {"name": "Blanket", "selected": false},
  // Add more services to the list as needed
];


 Widget build(BuildContext context) {
    BlocProvider.of<TripCubit>(context).showAllTrip(); // Initiate fetching trips

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trips',
          style: TextStyle(
            fontFamily: "DancingScript",
            color: Color(0xFF064061),
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                BlocProvider.of<TripCubit>(context).searchTrip(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  fontFamily: "DancingScript",
                  color: Color(0xFF064061),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                prefixIcon: Icon(Icons.search),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              BlocProvider.of<AddTripCubit>(context).getServices();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Add_Trip();
                },
              );
            },
            icon: Icon(
              Icons.add_location_alt_outlined,
              color: Colors.blue,
            ),
            label: Text(
              'Add Trip',
              style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 3,
              textStyle: TextStyle(fontSize: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          SizedBox(height: 10),
          BlocConsumer<TripCubit,TripState>(
  listener: (context, state) {
    if (state is TripErrorState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(state.errorMessage.toString()),
        ),
      );
      BlocProvider.of<TripCubit>(context).showAllTrip(); 
    } else if (state is TripLoadedState) {
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

    }
  },
            builder: (context, state) {
              if (state is TripLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TripLoadedState) {
                final trips = state.Tripdata;
                if (trips.isEmpty) {
                  return Center(child: Text('there is no trip to show'));
                }
                return Expanded(
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: trips.length,
                    itemBuilder: (BuildContext context, int index) {
                      Trip trip = trips[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Trip_Drawer(trip: trip)),
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Material(
                                elevation: 7,
                                borderRadius: BorderRadius.circular(20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 400,
                                    width: 700,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                    child: TypeSlider(images: trip.tripPhotos),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 14,
                              child: Container(
                                padding: EdgeInsets.only(left: 16),
                                width: 500,
                                color: Colors.white.withOpacity(0.6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 7),
                                    Row(
                                      children: [
                                       AutoSizeText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                             trips[index].tripName,
                              style: TextStyle(
                      fontFamily: "DancingScript",
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                            ),
                                        IconButton(
                                          onPressed: () async {
                                            BlocProvider.of<EditTripCubit>(context).getServices();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Edit_Trip(data: state.Tripdata[index]);
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.edit, color: Color(0XFF1B4158)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Color(0XFF1B4158),
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        AutoSizeText(
                                          trips[index].fromDate,
                                          style: TextStyle(color: Colors.black, fontSize: 13),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.location_on,
                                          color: Color(0XFF1B4158),
                                          size: 16,
                                        ),
                                        Text(
                                          trips[index].destination,
                                          style: TextStyle(color: Colors.black, fontSize: 13),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Color(0XFF1B4158),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Delete Trip',
                                                    style: TextStyle(
                                                      fontFamily: "DancingScript",
                                                      color: Color(0xFF064061),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: Text('Are you sure you want to delete this Trip?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        BlocProvider.of<TripCubit>(context).deleteTrip(trips[index].id);
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is TripErrorState) {
                return  Text(state.errorMessage);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}             


