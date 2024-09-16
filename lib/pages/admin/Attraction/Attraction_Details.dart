
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserva/cubits/admin/Add_Attraction/add_attraction_cubit.dart';
import 'package:reserva/cubits/admin/editAttraction/edit_attraction_cubit.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/models/admin/details_Attraction.dart';
import 'package:reserva/models/admin/review.dart';
import 'package:reserva/pages/admin/Attraction/EditAttraction.dart';

import 'package:reserva/pages/admin/admin_drawer.dart';
import 'dart:io';

import 'package:reserva/widgets/admin/icon_edit.dart';

import '../../../cubits/admin/atrractiondetails/attraction_details_cubit.dart';






class AttractionDetails extends StatefulWidget {
    final Attraction attraction;
  
  AttractionDetails({required this.attraction});

  @override
  _AttractionDetailsState createState() => _AttractionDetailsState();
}

class _AttractionDetailsState extends State<AttractionDetails> {
  late AttractionDetailsCubit _attractionDetailsCubit;
  
  @override
  void initState() {
    super.initState();
    _attractionDetailsCubit = AttractionDetailsCubit();
    _attractionDetailsCubit.fetchAttractionDetailsAndReviews(widget.attraction.id);
  }
  String? image;
  final _imagePicker = ImagePicker();


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          widget.attraction.attractionName,
          style: TextStyle(
            color: const Color(0xFF064061),
            fontSize: 30,
          ),
        ),actions: [IconButton(icon: Icon(Icons.close),onPressed: (){
      Navigator.of(context).pop();
    },)],),
      body: ListView(
        children: [
          buildAttractionDetails(widget.attraction),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [  
              SizedBox( width: 3,),
              buildImageSelectionButton(widget.attraction),
              SizedBox( width: 800,)],),
          SizedBox(height: 30,),
        buildReviewsTable(context, widget.attraction),
        ],
      ),
    );
  }

  Widget buildAttractionDetails(Attraction attraction) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
  width: 512.0,
  height: 400.0,
  child: Image.network(
    attraction.attractionPhoto != null && attraction.attractionPhoto.isNotEmpty
        ? attraction.attractionPhoto
        : 'images/Tourism-in-Milan-1024x585.jpg',
    fit: BoxFit.cover,
  ),

          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: NetworkImage(widget.attraction.attractionPhoto??'images/Tourism-in-Milan-1024x585.jpg'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  
                  children: [
                    Text(
                      widget.attraction.attractionName,
                      style: TextStyle(
                      fontFamily: "DancingScript",
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),

                    ),
                  
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Text(
                      widget.attraction.about,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  
                  children: [ 
                    Icon(Icons.location_city_rounded,color:Color(0xFF064061),),
                    Text(
                      'City Name : ',
                      style: TextStyle(
                        color: Color(0xFF064061),
                        fontSize: 20,
                      ),
                    ),
                      Text(
                      widget.attraction.city.cityName,
                      style: TextStyle(
                      
                        fontSize: 20,
                        
                      ),
                    ),
                    SizedBox()
                    
                    
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  
                  children: [
                     // Icon(Icons.share_arrival_time_sharp,color:Color(0xFF064061),),
                    Text(
                      'Attraction Type : ',
                      style: TextStyle(
                        color: Color(0xFF064061),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                    widget.attraction.attractionType.attractionTypeName,
                      style: TextStyle(
                        
                        fontSize: 20,
                        
                      ),
                    ),
                    SizedBox()
                    
                    
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        
                    Text(
                      'Open_At : ',
                      style: TextStyle(
                        color: Color(0xFF064061),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.attraction.openAt,
                      style: TextStyle(
                        color: Color(0xFF064061),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 200),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Close_At : ',
                      style: TextStyle(
                        color: Color(0xFF064061),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.attraction.closeAt,
                      style: TextStyle(
                        color: Color(0xFF064061),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 200),
                    
                  ],
                ),
                SizedBox(height: 50),
                image != null && File(image!).existsSync()
                    ? Image.network(
                        image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget buildImageSelectionButton(Attraction attraction) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
      BlocProvider.of<EditAttractionCubit>(context).getFilterscity();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditAttraction(data: attraction,);
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
                'Edit  Attraction',
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.add_a_photo, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }


}



 Widget buildReviewsTable(BuildContext context, Attraction attraction) {
  final reviewdata = BlocProvider.of<AttractionDetailsCubit>(context).fetchreview(attraction.id);

  return BlocBuilder<AttractionDetailsCubit, AttractionDetailsState>(
    builder: (context, state) {
      if (state is AttractionDetailsInitial || state is AttractionDetailsLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is reviewDetailsLoadedState) {
        final reviews = state.review;
          if (reviews == null || reviews.isEmpty) {
          return Center(child: Text('No reviews available'));
        }
        return DataTable(
          columnSpacing: 1.0,
          horizontalMargin: 10.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.0),
          ),
          columns: [
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(color: Colors.blue),
              ),
              numeric: false,
              tooltip: 'User Name',
            ),
            DataColumn(
              label: Text(
                'Comment',
                style: TextStyle(color: Colors.blue),
              ),
              numeric: false,
              tooltip: '',
            ),
          ],
          rows: reviews.map<DataRow>((review) {
            return DataRow(cells: [
                  DataCell(Text(review.userName ?? 'No Name')),
              DataCell(Text(review.review ?? 'No Comment')),
            ]);
          }).toList(),
        );
      } else if (state is AttractionDetailsErrorState) {
        // Error state, display an error message
        return Center(child: Text('Error: ${state.errorMessage}'));
      }

      return Container();
    },
  );
}










