// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/models/admin/dashboard_model.dart';
import 'package:reserva/widgets/admin/dashboard/LastClient.dart';
import 'package:reserva/widgets/admin/card.dart';
import 'package:reserva/widgets/admin/dashboard/lastAttraction.dart';
import 'package:reserva/widgets/admin/dashboard/lastflight.dart';
import 'package:reserva/widgets/admin/dashboard/lasthotel.dart';

class DashboardPage extends StatelessWidget {
 
 
  Widget build(BuildContext context) {
  BlocProvider.of<DashboardCubit>(context).getAllMydashboard();
        // BlocProvider.of<DashboardCubit>(context).showlastClients();
        // BlocProvider.of<DashboardCubit>(context).showlastFlights();
        // BlocProvider.of<DashboardCubit>(context).showlastHotel();
        // BlocProvider.of<DashboardCubit>(context).showlastattractions();
          
    return 
    BlocBuilder<DashboardCubit, dashboardState>(
      builder: (context, state) {
        if (state is dashboardLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is dashboardSuccess) {
          return 
          Scaffold(
            body: ListView(
              children: [
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                      fontFamily: "DancingScript",
                     // color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                card_page(
                  newCompanies: state.newCompanies, totalReservations: state.totalReservations, newUsers:state.newUsers,),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Last Users",
                  
                  style: TextStyle(   //color: Theme.of(context).brightness == Brightness.light ? Colors.black : const Color(0xFF064061),
                    fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                  
             // Lastclient(),
              DataTable(
            columnSpacing: 1.0,
            horizontalMargin: 10.0,
            decoration: BoxDecoration(
             // color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            columns: [
              DataColumn(
                label: Text('Name', style: TextStyle(color: Colors.blue)),
              ),
              DataColumn(
                label: Text('Email', style: TextStyle(color: Colors.blue)),
              ),
              DataColumn(
                label: Text('Phone Number', style: TextStyle(color: Colors.blue)),
              ),
              DataColumn(
                label: Text('Gender', style: TextStyle(color: Colors.blue)),
              ),
            ],
            rows: (state.client).map((client) {
              return DataRow(cells: [
                DataCell(Text(client.name ?? '')),
                DataCell(Text(client.email ?? '')),
                DataCell(Text(client.phone ?? '')),
                DataCell(Text(client.gender ?? '')),
              ]);
            }).toList(),
          ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Text("Last Attraction Table",
                        style: TextStyle(//color: const Color(0xFF064061),
                          fontSize: 25)),
                    SizedBox(width: 420),
                    Text("Last Flight Table",
                        style: TextStyle(//color: const Color(0xFF064061),
                          fontSize: 25)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                      //lastattraction(),
                      DataTable(
            columnSpacing: 1.0,
          horizontalMargin: 10.0,
          decoration: BoxDecoration(
           // color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
                        columns: [
                          DataColumn(
                            label: Text('Attraction Name', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('City', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('Attraction Type', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                        rows: 
                        (state.Attraction).map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.attractionName ?? '')),
                            DataCell(Text(data.city ?? '')),
                            DataCell(Text(data.attractionType ?? '')),
                          ]);
                        }).toList() 
                      )
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child:
                      //lastflight(),
                      DataTable(
                              columnSpacing: 1.0,
          horizontalMargin: 10.0,
          decoration: BoxDecoration(
          //  color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
                        columns: [
                          DataColumn(
                            label: Text('Airway Name', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('From City', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('To City', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('seatsNum', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                        rows:(state.Flight).map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.airwayName ?? '')),
                            DataCell(Text(data.fromCity ?? '')),
                            DataCell(Text(data.toCity ?? '')),
                    DataCell(Text(int.parse(data.seatsNum.toString()).toString())),
                          ]);
                        }).toList()
                      )
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Last Hotels",
                    style: TextStyle(//color: const Color(0xFF064061),
                      fontSize: 25)),
                SizedBox(height: 20),
              //Lasthotel(),
                DataTable(
            columnSpacing: 1.0,
          horizontalMargin: 10.0,
          decoration: BoxDecoration(
           // color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
                  columns: [
                    DataColumn(
                      label: Text('Hotel', style: TextStyle(color: Colors.blue)),
                    ),
                    DataColumn(
                      label: Text('City', style: TextStyle(color: Colors.blue)),
                    ),
                    DataColumn(
                      label: Text('Stars', style: TextStyle(color: Colors.blue)),
                    ),
                    DataColumn(
                      label: Text('Number of Rooms', style: TextStyle(color: Colors.blue)),
                    ),
                    DataColumn(
                      label: Text('Description', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                  rows: (state.Hotel).map((hotelData) {
                    return DataRow(cells: [
                      DataCell(Text(hotelData.hotelName)),
                      DataCell(Text(hotelData.city)),
                      
                      DataCell(Text(int.parse(hotelData.stars.toString()).toString())),
                      DataCell(Text(int.parse(hotelData.numberOfRooms.toString()).toString())),
                
                      DataCell(Text(hotelData.description)),
                    ]);
                  }).toList() 
                ),
              ],
            ),
          );
        } else if (state is dashboardFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}



