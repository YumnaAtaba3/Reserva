
// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, prefer_const_constructors

import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reserva/cubits/admin/Add_Attraction/add_attraction_cubit.dart';
import 'package:reserva/cubits/admin/Attraction/attraction_cubit.dart';
import 'package:reserva/cubits/admin/editAttraction/edit_attraction_cubit.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/models/admin/atttractionType.dart';
import 'package:reserva/models/admin/details_Attraction.dart';
import 'package:reserva/pages/admin/Attraction/Attraction_drawer.dart';
import 'package:reserva/pages/admin/Attraction/EditAttraction.dart';
import 'package:reserva/widgets/admin/Attraction/Attraction_search.dart';
import 'package:reserva/widgets/admin/Attraction/showDialogAttraction.dart';


class AttractionPage extends StatelessWidget {
        final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final textFieldKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AttractionCubit>(context).fetchAttractions();


return Scaffold(
  appBar: AppBar(
    title: Text(
      'Attractions',
      style: TextStyle(
        fontFamily: "DancingScript",
        color: Color(0xFF064061),
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),
    ),
  ),
  body:Column(

          children: [ 
              Padding(
                padding: EdgeInsets.all(10),
                child:
                //  TextFormField(
                //   onTap: () async {
                //     final result = await showSearch(
                //       context: context,
                //       delegate: datasearch(
                //         data: state.attraction,
                //       ),
                //     );
                //   },
                //   decoration: InputDecoration(
                //     hintText: "Search",
                //     hintStyle:  TextStyle(
                //       fontFamily: "DancingScript",
                //       color: Color(0xFF064061),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 25,
                //     ),
                //     prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 8, 65, 111)),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(30),
                //       borderSide: BorderSide.none,
                //     ),
                //     filled: true,
                //     fillColor: Colors.grey[200],
                //   ),
                // ),
                  TextFormField(
                            
                            onChanged: (value) {
                            BlocProvider.of<AttractionCubit>(context).searchAttractions(value);
                            },
                            decoration: InputDecoration(
                              
                              hintText: "Search",
                              hintStyle:   TextStyle(
                      fontFamily: "DancingScript",
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 25

                    ),
 
  
                              prefixIcon: Icon(Icons.search),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                            ),
              ),),
              
                
                ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<AddAttractionCubit>(context).getFilters();
        BlocProvider.of<AddAttractionCubit>(context).getFilterscity();
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Add_Attraction();
          },
        );
      },
      icon: Icon(
        Icons.add_location_alt_outlined,
        color: Colors.blue,
      ),
      label: Text('Add Attracion',  style: TextStyle(
                      fontFamily: "DancingScript",
                      //color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
      style: ElevatedButton.styleFrom(
      
        elevation: 3, // Elevation of the button
        textStyle: TextStyle(fontSize: 16), // Text style of the button label
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding around the button content
      ),
    
              ),
     SizedBox(height: 10,),
     
   BlocBuilder<AttractionCubit, AttractionState>(
    builder: (context, state) {
      if (state is AttractionInitial || state is AttractionLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is AttractionLoadedState) {
        final attractions = state.attraction;

        if (attractions.isEmpty) {
          return Center(child: Text(''));
          
        }

      //   return Column(

      //     children: [ 
      //         Padding(
      //           padding: EdgeInsets.all(10),
      //           child:
      //           //  TextFormField(
      //           //   onTap: () async {
      //           //     final result = await showSearch(
      //           //       context: context,
      //           //       delegate: datasearch(
      //           //         data: state.attraction,
      //           //       ),
      //           //     );
      //           //   },
      //           //   decoration: InputDecoration(
      //           //     hintText: "Search",
      //           //     hintStyle:  TextStyle(
      //           //       fontFamily: "DancingScript",
      //           //       color: Color(0xFF064061),
      //           //       fontWeight: FontWeight.bold,
      //           //       fontSize: 25,
      //           //     ),
      //           //     prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 8, 65, 111)),
      //           //     border: OutlineInputBorder(
      //           //       borderRadius: BorderRadius.circular(30),
      //           //       borderSide: BorderSide.none,
      //           //     ),
      //           //     filled: true,
      //           //     fillColor: Colors.grey[200],
      //           //   ),
      //           // ),
      //             TextFormField(
                            
      //                       onChanged: (value) {
      //                       BlocProvider.of<AttractionCubit>(context).searchAttractions(value);
      //                       },
      //                       decoration: InputDecoration(
                              
      //                         hintText: "Search",
      //                         hintStyle:   TextStyle(
      //                 fontFamily: "DancingScript",
      //                 color: Color(0xFF064061),
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 25

      //               ),
 
  
      //                         prefixIcon: Icon(Icons.search),
      //                         enabledBorder: InputBorder.none,
      //                         focusedBorder: InputBorder.none,
                              
      //                       ),
      //         ),),
              
                
      //           ElevatedButton.icon(
      // onPressed: () {
      //   BlocProvider.of<AddAttractionCubit>(context).getFilters();
      //   BlocProvider.of<AddAttractionCubit>(context).getFilterscity();
        
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return Add_Attraction();
      //     },
      //   );
      // },
      // icon: Icon(
      //   Icons.add_location_alt_outlined,
      //   color: Colors.blue,
      // ),
      // label: Text('Add Attracion',  style: TextStyle(
      //                 fontFamily: "DancingScript",
      //                 color: Color(0xFF064061),
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 30,
      //               ),),
      // style: ElevatedButton.styleFrom(
      
      //   elevation: 3, // Elevation of the button
      //   textStyle: TextStyle(fontSize: 16), // Text style of the button label
      //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding around the button content
      // ),
    
      //         ),
            // SizedBox(height: 10,),
      return      Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: attractions.length,
                itemBuilder: (context, index) {
                  final attraction = attractions[index];
                  final photos = attraction.attractionPhoto;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>attration_det(attraction: attraction),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              attraction.attractionPhoto.isNotEmpty
                                  ? attraction.attractionPhoto
                                  : 'images/Tourism-in-Milan-1024x585.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          ListTile(
                            title:AutoSizeText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              attraction.attractionName,
                              style: TextStyle(
                      fontFamily: "DancingScript",
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                              children: [
IconButton(onPressed:() async {
      BlocProvider.of<EditAttractionCubit>(context).getFilterscity();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditAttraction(data: attraction,);
          },
        );
          
    
        }, icon: Icon(Icons.edit, //color: Color(0XFF1B4158)
        ),),
                                IconButton(
                                  icon: Icon(Icons.delete, //color: Color(0XFF1B4158)
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Delete Attraction',
                                            style: TextStyle(
                                                fontFamily: "DancingScript",
                                                color: Color(0xFF064061),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text('Are you sure you want to delete this Attraction?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                    BlocProvider.of<AttractionCubit>(context).deleteAttraction(attraction.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete',style: TextStyle(color: Colors.red),),
                                ),
                                          ],
                                        );
                                      },
                                    );
                                  
                                   // BlocProvider.of<AttractionCubit>(context).deleteAttraction(attraction.id);
                                  },
                                ),
                              ],
                            ),
                            subtitle: AutoSizeText(
                              attraction.about,
                              //style: TextStyle(color: const Color(0xFF064061)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
          //   ),
          // ],
        // );
      } else if (state is AttractionErrorState) {
        return Center(child: Text('${state.errorMessage}'));
      }

      return Container();
    },
  ),]));
  

  }}









//     return Scaffold(
//       appBar: AppBar(
        
//         title: Text( 
//         'Attractions'
//         , style: TextStyle(
//             fontFamily: "DancingScript",
//             color: Color(0xFF064061),
//             fontWeight: FontWeight.bold,
//             fontSize: 35,)),
//       ),
//       body: BlocBuilder<AttractionCubit, AttractionState>(
//         builder: (context, state) {
//           if (state is AttractionInitial) {
            
//             return Center(child: CircularProgressIndicator());
//           } else if (state is AttractionLoadingState) {
            
//             return Center(child: CircularProgressIndicator());
//           } else if (state is AttractionLoadedState ) {
          
//             final attractions = state.attraction;
//            // final cities =state;

//             if (attractions.isEmpty) {
//               return Center(child: Text('No data found.'));
//             }

// //             return GridView.builder(
// //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 4, // Number of columns
// //             crossAxisSpacing: 5, // Spacing between columns
// //             mainAxisSpacing: 5, // Spacing between rows
// //           ),
// //           itemCount: attractions.length,
// //           itemBuilder: (context, index) {
// //     final attractionData = attractions[index];
// //     final attraction = attractionData;
// //     final photos = attractionData.attractionPhoto;
  
// //             return InkWell(
// //           onTap: () {
// //           Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => attration_det(attraction:attractions[index]),
// //           ),);
// //                   },
                
      

// //                     child: Card(
                      
// //           child: Column(
// //             children:[
// //         Expanded(
// //           child:
// //     Image.network(
// //     attraction.attractionPhoto != null && attraction.attractionPhoto.isNotEmpty
// //         ? attraction.attractionPhoto
// //         : 'images/Tourism-in-Milan-1024x585.jpg',
// //     fit: BoxFit.cover,
// //   ),
// // ),
// //         ListTile(
// //           title: Text(
// //             attraction.attractionName,
// //             style: TextStyle(
// //               color: const Color(0xFF064061),
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           trailing: delete_icon(),
// //           subtitle:AutoSizeText(
// //             attraction.about,
// //           style: TextStyle(   color: const Color(0xFF064061),),
// //           maxLines: 2,
// //           overflow: TextOverflow.ellipsis,
// //         ),
          
            
// //         ),
// //             ],
// //           ),)
                  
// //                 );
// //               },
// //             );

//  return Column(
//     children: [
//       Expanded(
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4,
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//           ),
//           itemCount: attractions.length,
//           itemBuilder: (context, index) {
//             final attraction = attractions[index];
//             final photos = attraction.attractionPhoto;

//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => attration_det(attraction: attraction),
//                   ),
//                 );
//               },
//               child: Card(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Image.network(
//                         attraction.attractionPhoto.isNotEmpty
//                             ? attraction.attractionPhoto
//                             : 'images/Tourism-in-Milan-1024x585.jpg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     ListTile(
//                       title: Text(
//                         attraction.attractionName,
//                         style: TextStyle(
//                           color: const Color(0xFF064061),
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       trailing:IconButton(icon:Icon(Icons.delete,color:  Color(0XFF1B4158),),onPressed: (){
//                         BlocProvider.of<AttractionCubit>(context).deleteAttraction(state.attraction[index].id);
//                       },),

//                       subtitle: AutoSizeText(
//                         attraction.about,
//                         style: TextStyle(color: const Color(0xFF064061),),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ))]); } else if (state is TypeLoadedState) {
//            final  attractionTypes = state.attractiontype; 
//             return Container(); 
//           } else {
//             return Center(child: Text('Error loading data.'));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: const Color(0xFF064061),
//       onPressed:(){ _showAddSiteDialog(context);},
//         child: Icon(Icons.add_location_alt_outlined,color: Colors.white,)
        
//       ),
//     );
  

//           } else if (state is AttractionErrorState) {
//             // Error state, display an error message
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           }

//           return Container();
//         },
   



// final ImagePicker _imagePicker = ImagePicker();
//   File? selectedImage;

//   void _selectImage(BuildContext context) async {
//     final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       selectedImage = File(pickedImage.path);
//     }
//   }


//   List<String> cities = ['Egypt','franca','syria', 'Italy', 'UAE'];
//   List<String> attractionTypes = ['pyramid','Tower', 'Historical place', ];

    
//   @override
//   Widget build(BuildContext context) {
//         final attrationcubit = BlocProvider.of<AttractionCubit>(context);
//           BlocBuilder<AttractionCubit, AttractionState>(
//           builder: (context, state) {
//             if (state is AttractionInitial) {
//               return Center(
//                 child: Text('Press the refresh button to load attraction.'),
//               );
//             } else if (state is AttractionLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is AttractionLoadedState) {
//               final attration = state.attraction;

//               if (attration.isEmpty) {
//                 return Center(
//                   child: Text('No data found.'),
//                 );
//               }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Attraction', style: TextStyle(
//                 fontFamily: "DancingScript",
//                 color: Color(0xFF064061),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 35),
//             textAlign: TextAlign.center,
//         ),
//         actions: [
//     IconButton(
//       onPressed: () {
//         showSearch(
//           context: context,
//           delegate: datasearch(data:sites ),
//         );
//       },
//       icon: Icon(Icons.search, color: const Color(0xFF064061),size: 30,),
//     ),
//   ],
//       ),
      
//       body: Container(
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4, // Number of columns
//             crossAxisSpacing: 10, // Spacing between columns
//             mainAxisSpacing: 10, // Spacing between rows
//           ),
//           itemCount: sites.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//           onTap: () {
//           Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => attration_det(attraction: sites[index]),
//           ),
//         );
        

//         },
//         child: Card(
//           child: Column(
//             children: <Widget>[
//         Expanded(
//           child: sites[index].image != null
//             ? Image.asset(
//                 sites[index].image!,
//                 fit: BoxFit.cover,
//               )
//             : Placeholder(),
//         ),
//         ListTile(
//           title: Text(
//             sites[index].name,
//             style: TextStyle(
//               color: const Color(0xFF064061),
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           trailing: delete_icon(),
//           subtitle:AutoSizeText(
//             sites[index].description,
//           style: TextStyle(   color: const Color(0xFF064061),),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
          
            
//         ),
//             ],
//           ),
        
//         ));}),
//       ));} else if (state is AttractionErrorState) {
//               return Center(
//                 child: Text('Error: ${state.errorMessage}'),
//               );
//             }

//             return Container();
//           },);
//   floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFF064061),
//         onPressed: _showAddSiteDialog,
//         child: Icon(Icons.add_location_alt_outlined,color: Colors.white,)

// );
            
// }}

// }





  //     } else if (state is TypeLoadedState) {
  //       final attractionTypes = state.attractionsTypes;
      
  //       floatingActionButton: FloatingActionButton(
  //   backgroundColor: const Color(0xFF064061),
  //   onPressed: () {
  //     _showAddSiteDialog(context,attractionTypes);
  //   },
  //   child: Icon(Icons.add_location_alt_outlined, color: Colors.white),
  // );// Placeholder for now, update as needed







