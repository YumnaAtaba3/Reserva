import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lasthotel/lasthotel_cubit.dart';

class Lasthotel extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
   BlocProvider.of<LasthotelCubit>(context).showlastHotel();
    return BlocBuilder<LasthotelCubit, LasthotelState>(
      builder: (context, state) {
        if (state is LastHotelloading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is dashboardSuccessLastHotel) {
          return    DataTable(
            columnSpacing: 1.0,
          horizontalMargin: 10.0,
          decoration: BoxDecoration(
            color: Colors.white,
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
                );
        } else if (state is EmptyLastHotel) {
          return Center(
            child: Text((state as EmptyLastHotel).message),
          );
        } else if (state is  LastHotelFailure) {
          return Center(
            child: Text((state as LastHotelFailure).message),
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