import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reserva/models/admin/trip.dart';
import 'package:reserva/pages/admin/Trip/Trip_drawer.dart';

class Tripdatasearch extends SearchDelegate{
  final  List<Trip> data;
Tripdatasearch({ required this.data});


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.close),onPressed: (){
      Navigator.of(context).pop();
    },)];
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
    Navigator.of(context).pop();
    },);
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return 
    buildSuggestions(context);
  
  }
    
 @override
Widget buildSuggestions(BuildContext context) {
   final ScrollController controllerr = ScrollController();

  
 
  final ScrollController scrollController = ScrollController();
  double itemWidth = 350;
  double itemHeight = 180;
  FilePickerResult? result;
  TextEditingController _imageController = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final textFieldKey = GlobalKey();
  List<Trip> filteredData = data.where((trip) {
    String tripName = trip.tripName.toLowerCase();
    String queryLowerCase = query.toLowerCase();

    return tripName.contains(queryLowerCase);
  }).toList();

  if (filteredData.isEmpty) {
    return Center(child: Text("No results found"));
  }

  return  GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.2,
            ),
            itemCount: filteredData.length,
            itemBuilder: (BuildContext context, int index) {
                Trip trip =filteredData[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                                        MaterialPageRoute(builder: (context) => Trip_Drawer(trip:filteredData[index] )),
                  //  MaterialPageRoute(builder: (context) => TripDetails(tripId: trips[index].id, )),
                  );
                },
                child:  Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 7,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: itemHeight,
                  width: itemWidth,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller:scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount:  filteredData.length,
                    itemBuilder: (context, index) {
                    
                      return Container(
                        width: itemWidth,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child:
                          
                            Image.network(
                                          filteredData[index].tripPhotos[index],
                                          fit: BoxFit.cover,
                                        )); 
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 7,
            left: 8,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                 scrollController.animateTo(
                   scrollController.offset - itemWidth,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 7,
            right: 8,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  scrollController.animateTo(
                    scrollController.offset + itemWidth,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 14,
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: 330,
              color: Colors.white.withOpacity(0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7),
                  Text(
                    filteredData[index].tripName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFF1B4158),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Color(0XFF1B4158),
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        filteredData[index ].fromDate,
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      SizedBox(width: 15),
                      Icon(
                        Icons.location_on,
                        color: Color(0XFF1B4158),
                        size: 16,
                      ),
                      Text(
                      filteredData[index].destination,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 40),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Color(0XFF1B4158),
                        onPressed: () {
                          // Handle delete action
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
          );
}}