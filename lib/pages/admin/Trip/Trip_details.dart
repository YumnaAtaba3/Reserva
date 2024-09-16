
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/AddTrip/add_trip_cubit.dart';
import 'package:reserva/cubits/admin/EditTrip/edit_trip_cubit.dart';
import 'package:reserva/models/admin/trip.dart';
import 'package:reserva/pages/admin/Trip/EditTrip.dart';





class tripDetails extends StatefulWidget {
  final Trip trip;

  tripDetails({Key? key, required this.trip}) : super(key: key);

  @override
  State<tripDetails> createState() => _tripDetailsState();
}

class _tripDetailsState extends State<tripDetails> {
  late String selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.trip.tripPhotos.isNotEmpty ? widget.trip.tripPhotos[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Details',
          style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 35),
            textAlign: TextAlign.center,
          
        ),actions: [IconButton(icon: Icon(Icons.close),onPressed: (){
      Navigator.of(context).pop();
    },)],),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              image: DecorationImage(
                image: 
                NetworkImage(selectedImage) ,
                
                
             
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.trip.tripPhotos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedImage = widget.trip.tripPhotos[index];
                              });
                            },
                          child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                widget.trip.tripPhotos[index], // Load image from URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
    Card(
  elevation: 0,
  // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(15.0),
  // ),
  color: Colors.white,
  child: Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
              "Trip Name: ",
                style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 33),
  ),        Text(
              "${widget.trip.tripName}",
              style: TextStyle(
                fontFamily: "DancingScript",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 88, 163, 210),
              ),),
              SizedBox(width:250,),
      Container(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
      BlocProvider.of<EditTripCubit>(context).getServices();
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Edit_Trip(data:widget.trip,);
          },
        );
          
    
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF064061),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFF064061),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Edit Trip',
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.add_a_photo, color: Colors.white),
            ],
          ),
        ),
      ),
    )
                
            ],
          ),
        SizedBox(height: 10),
         Row(
          children: [
            Icon(Icons.people, color: Colors.blue, size: 30),
            SizedBox(width: 10),
            Text(
              "Number of People: ${widget.trip.maxNumberOfPeople}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.green, size: 30),
            SizedBox(width: 10),
            Text(
              "Number of Days: ${widget.trip.numberOfDays}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.person, color: Colors.orange, size: 30),
            SizedBox(width: 10),
            Text(
              "Required Age: ${widget.trip.requiredAge}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 10),
        Text(
          "Details:",
          style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 22),
        ),
        SizedBox(height: 10),
        Text(
          widget.trip.tripDetails,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Trip Programme:",
          style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 22),
        ),
        SizedBox(height: 10),
        Text(
          widget.trip.tripProgramme,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          "Price: \$${widget.trip.price}",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color:const Color.fromARGB(255, 88, 148, 197),
          ),
        ),
      ],
    ),
  ),
),
                    
Card(
    color: Colors.white,
  elevation: 0,
  // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(15.0),
  // ),
  child: Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Services:",
            style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 27),
        ),
        SizedBox(height: 10),
        Row(
          children: widget.trip.tripServices.map((service) {
            return Padding(
              padding: EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(
                  service.serviceName,
                  style: TextStyle(fontSize: 16),
                ),
                backgroundColor: const Color.fromARGB(255, 88, 148, 197),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  ),
),]))))
        ],
      ),
    );
  }
}