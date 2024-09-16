// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight/cubit/edit_flight_cubit.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/widgets/company_owner/flights/edit_flight.dart';
import 'package:reserva/widgets/company_owner/flights/flights_time_data_table.dart';

class FlightCard extends StatelessWidget {
  FlightCard({super.key, required this.data});
  final List<Flight> data;

  bool checked_bag = false;

  bool hand_bag = false;

  List flights = [
    {
      'from_city': 'Damascus',
      'to_city': 'Rome',
      'flight_class': 'First Class',
      'seat_selection': '2A',
      'seats_num': '100'
    },
    {
      'from_city': 'Damascus',
      'to_city': 'Rome',
      'flight_class': 'First Class',
      'seat_selection': '2A',
      'seats_num': '100'
    },
    {
      'from_city': 'Damascus',
      'to_city': 'Rome',
      'flight_class': 'First Class',
      'seat_selection': '2A',
      'seats_num': '100'
    },
    {
      'from_city': 'Damascus',
      'to_city': 'Rome',
      'flight_class': 'First Class',
      'seat_selection': '2A',
      'seats_num': '100'
    },
    {
      'from_city': 'Damascus',
      'to_city': 'Rome',
      'flight_class': 'First Class',
      'seat_selection': '2A',
      'seats_num': '100'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      width: 600,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length, // Create 5 FlightCard widgets
          itemBuilder: (context, i) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Container(
                              height: 210,
                              width: 600,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: const [
                                        Color(0XFF2C516C),
                                        Color.fromARGB(255, 202, 206, 207)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.5, 0.5]),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "From City:",
                                              style: TextStyle(
                                                 // color: Colors.white
                                                  ),
                                            ),
                                            Text(data[i].fromCity.cityName,
                                                style: TextStyle(
                                                   // color: Colors.white
                                                    ))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                FontAwesomeIcons.planeDeparture,
                                               // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Flight Classes: ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "First Class:" +
                                                      data[i]
                                                          .flightClasses[0]
                                                          .seatSelection,
                                                  style: TextStyle(
                                                      // color: Color.fromARGB(
                                                      //     255, 202, 206, 207)
                                                          ),
                                                ),
                                                Text(
                                                  "  Economy Class: " +
                                                      data[i]
                                                          .flightClasses[1]
                                                          .seatSelection,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 202, 206, 207)),
                                                ),
                                                Text(
                                                  "  Business Class: " +
                                                      data[i]
                                                          .flightClasses[2]
                                                          .seatSelection,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 202, 206, 207)),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "Seat Number:" +
                                                    data[i].seatsNum.toString(),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 202, 206, 207))),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text("To City:",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            Text(data[i].toCity.cityName,
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    /*Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          flightinfo.nyc,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(flightinfo.time,
                                            style: TextStyle(color: Colors.white)),
                                        Text(flightinfo.ldn,
                                            style: TextStyle(color: Colors.white))
                                      ],
                                    ),*/
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Text(
                                      "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      /*children: [
                                        Text(
                                          flightinfo.date,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        Text(flightinfo.depature,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16)),
                                        Text(flightinfo.number,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16))
                                      ],*/
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                                value: data[i].checkedBag,
                                                activeColor: Colors.blue,
                                                onChanged: (val) {
                                                  // setState(() {
                                                  //   checked_bag = val!;
                                                  // });
                                                }),
                                            Text(
                                              "Checked Bag",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            // Text(
                                            //     "Seats num : " +
                                            //         flights[i]["seats_num"],
                                            //     style: TextStyle(
                                            //         color: Colors.white)),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  EditFlightCubit>(
                                                              context)
                                                          .getFilters();
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return EditFlight(
                                                              data: data[i]);
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(Icons.edit,
                                                        color: Colors.blue)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                                value: data[i].handBag,
                                                activeColor: Colors.blue,
                                                onChanged: (val) {
                                                  // setState(() {
                                                  //   hand_bag = val!;
                                                  // });
                                                }),
                                            Text("Hand Bag",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]))),
                          Positioned(
                              left: -5,
                              bottom: 0,
                              top: 0,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              )),
                          Positioned(
                              top: 0,
                              bottom: 0,
                              right: -5,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  "Flights Time:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                     // color: Color(0xFF064061),
                      fontFamily: 'DancingScript',
                      fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 600,
                      child: FlightsTimeTable(
                        data: data[i].flightTimes,
                        data2: data[i].id,
                        //data3: data[i].flightTimes[i]
                      )),
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ShowFlightCubit>(context)
                          .deleteFlight(id: data[i].id.toString());
                    },
                    icon: Icon(Icons.delete, color: Colors.blue)),
              ],
            );
          }),
    );
  }
}
