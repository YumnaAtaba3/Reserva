import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class HotelInfoCard extends StatelessWidget {
  final List<HotelInfo> data;
  HotelInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // if (data == null || data!.isEmpty) {
    //   return Center(
    //     child: Text("No hotel information available"),
    //   );
    // }
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Name: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064061),
                      ),
                    ),
                    TextSpan(
                      text: data[0].hotelName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Location: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064061),
                      ),
                    ),
                    TextSpan(
                      text: data[0].location,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Description: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064061),
                      ),
                    ),
                    TextSpan(
                      text: data[0].description,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "City: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064061),
                      ),
                    ),
                    TextSpan(
                      text: data[0].city.cityName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // return Container(
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           RichText(
    //             text: TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: "Name: ",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xFF064061),
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: data[0].hotelName,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           RichText(
    //             text: TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: "Description: ",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xFF064061),
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: data[0].description,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           RichText(
    //             text: TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: "Location: ",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xFF064061),
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: data[0].location,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           RichText(
    //             text: TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: "City: ",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xFF064061),
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: data[0].city.cityName,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    // return Container(
    //   height: 50,
    //   width: 40,
    //   child: Container(
    //     //color: Colors.white,
    //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       Row(
    //         children: [
    //           Text("Name:",
    //               style: TextStyle(
    //                   color: Color(0xFF064061), fontWeight: FontWeight.bold)),
    //           Text(data[0].hotelName)
    //         ],
    //       ),
    //       /* SizedBox(
    //                 width: 100,
    //               ),*/
    //       Row(
    //         children: [
    //           Text("Description:",
    //               style: TextStyle(
    //                   color: Color(0xFF064061), fontWeight: FontWeight.bold)),
    //           Flexible(
    //             child: Text(
    //               data[0].description,
    //               maxLines: 1,
    //             ),
    //           )
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "Location:",
    //             style: TextStyle(
    //                 color: Color(0xFF064061), fontWeight: FontWeight.bold),
    //           ),
    //           FittedBox(child: Text(data[0].location))
    //         ],
    //       ),
    //       /*  SizedBox(
    //             width: 200,
    //           ),*/
    //       Row(
    //         children: [
    //           Text("City:",
    //               style: TextStyle(
    //                   color: Color(0xFF064061), fontWeight: FontWeight.bold)),
    //           Text(data[0].city.cityName)
    //         ],
    //       )
    //     ]),
    //   ),
    // );
  }
}
