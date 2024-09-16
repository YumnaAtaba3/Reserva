

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/pages/admin/Attraction/Attraction.dart';
import 'package:reserva/pages/admin/Attraction/Attraction_Details.dart';
import 'package:reserva/pages/admin/Attraction/Attraction_drawer.dart';
import 'package:reserva/pages/admin/admin_drawer.dart';
import 'package:reserva/widgets/admin/Attraction/showDialogAttraction.dart';



class datasearch extends SearchDelegate{
  final  List<Attraction>data;
datasearch({ required this.data});


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
  List<Attraction> filteredData = data.where((attraction) {
    String attractionName = attraction.attractionName.toLowerCase();
    String queryLowerCase = query.toLowerCase();

    return attractionName.contains(queryLowerCase);
  }).toList();

  if (filteredData.isEmpty) {
    return Center(child: Text("No results found"));
  }

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    itemCount: filteredData.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => attration_det(attraction: filteredData[index]),
            ),
          );
        },
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  filteredData[index].attractionPhoto.isNotEmpty
                      ? filteredData[index].attractionPhoto
                      : 'images/Tourism-in-Milan-1024x585.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(
                  filteredData[index].attractionName,
                  style: TextStyle(
                    color: const Color(0xFF064061),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Color(0XFF1B4158)),
                  onPressed: () {
                    // BlocProvider.of<AttractionCubit>(context).deleteAttraction(filteredData[index].id);
                  },
                ),
                subtitle: AutoSizeText(
                  filteredData[index].about,
                  style: TextStyle(color: const Color(0xFF064061)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}}