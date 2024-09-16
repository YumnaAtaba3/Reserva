import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lastflight/lastflight_cubit.dart';

class lastflight extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
  BlocProvider.of<LastflightCubit>(context).showlastFlights();
    return BlocBuilder<LastflightCubit, LastflightState>(
      builder: (context, state) {
        if (state is Lastflightloading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is dashboardSuccessLastFlight) {
          return DataTable(
                              columnSpacing: 1.0,
          horizontalMargin: 10.0,
          decoration: BoxDecoration(
            color: Colors.white,
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
                      );
        } else if (state is EmptyLastFlight) {
          return Center(
            child: Text((state as EmptyLastFlight).message),
          );
        } else if (state is  LastflightFailure) {
          return Center(
            child: Text((state as LastflightFailure).message),
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}