// ignore_for_file: unnecessary_import, camel_case_types

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/pages/admin/Attraction/Attraction_drawer.dart';

class edit_icon extends StatefulWidget {
  final Attraction attraction;
  const edit_icon({super.key,required this.attraction});

  @override
  State<edit_icon> createState() => _edit_iconState();
}

class _edit_iconState extends State<edit_icon> {
  @override
  Widget build(BuildContext context) {
     
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      Text(
        widget.attraction.attractionName,
        style: TextStyle(
          color: Color(0xFF064061),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 16),
      Text(
        widget.attraction.about,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      SizedBox(height: 16),
      Text(
        'City Name : ${widget.attraction.city.cityName}',
        style: TextStyle(
          color: Color(0xFF064061),
          fontSize: 20,
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Attraction Type : ${widget.attraction.attractionType.attractionTypeName}',
        style: TextStyle(
          color: Color(0xFF064061),
          fontSize: 20,
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Open_At : ${widget.attraction.openAt}',
        style: TextStyle(
          color: Color(0xFF064061),
          fontSize: 20,
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Close_At : ${widget.attraction.closeAt}',
        style: TextStyle(
          color: Color(0xFF064061),
          fontSize: 20,
        ),
      ),
      SizedBox(height: 16),
      // image != null && File(image!).existsSync()
      //     ? Image.network(
      //         image!,
      //         width: 100,
      //         height: 100,
      //         fit: BoxFit.cover,
      //       )
      //     : SizedBox(),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          // Add your edit logic here
          // For example, you can navigate to an edit screen
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Color(0xFF064061),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text('Edit Details'),
      ),
    ],
  );
}
  }
