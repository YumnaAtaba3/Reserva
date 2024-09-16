import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/hotel_reservation/cubit/hotel_reservations_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/hotel_reservation/cubit/hotel_reservations_state.dart';
import 'package:reserva/widgets/company_owner/hotels/edit_hotel_reservations.dart';

class HotelReservationTable extends StatelessWidget {
  HotelReservationTable({super.key});

  List<HotelReservData> hotelReservDataList = [
    HotelReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'single room',
        '3-4-2024', '5-4-2024', 'true'),
    HotelReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'single room',
        '3-4-2024', '5-4-2024', 'true'),
    HotelReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'single room',
        '3-4-2024', '5-4-2024', 'true'),
    HotelReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'single room',
        '3-4-2024', '5-4-2024', 'true'),
    HotelReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'single room',
        '3-4-2024', '5-4-2024', 'true'),
  ];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HotelReservationsCubit>(context).showHotelReserv();
    return BlocBuilder<HotelReservationsCubit, HotelReservationsState>(
      builder: (context, state) {
        if (state is HotelReservationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HotelReservationsFailure) {
          return Center(
              child: Container(
            child: Text(state.message.toString()),
          ));
        }
        if (state is HotelReservationsEmpty) {
          return Center(
              child: Container(
            child: Text(state.message.toString()),
          ));
        }
        if (state is HotelReservationsSuccess) {
          return Container(
            width: double.infinity,
            child: DataTable(
              columnSpacing: 1.0, // Adjust the spacing between columns
              horizontalMargin: 10.0, // Add horizontal margin around the table
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              columns: [
                DataColumn(
                  label:
                      Text('User Name', style: TextStyle(color: Colors.blue)),
                  numeric: false,
                  tooltip: 'User Name',
                ),
                /* DataColumn(
                  label: Text('Email', style: TextStyle(color: Colors.blue)),
                  numeric: false,
                  tooltip: 'Email',
                ),*/
                DataColumn(
                  label: Text('Phone number',
                      style: TextStyle(color: Colors.blue)),
                  numeric: false,
                  tooltip: 'Phone number',
                ),
                DataColumn(
                  label:
                      Text('Room Type', style: TextStyle(color: Colors.blue)),
                  numeric: false,
                  tooltip: 'Room Type',
                ),
                DataColumn(
                  label: Text(
                    'From-Day',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'From-Day',
                ),
                DataColumn(
                  label: Text(
                    'To-Day',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'To-Day',
                ),

                /*  DataColumn(
                  label: Text("               Actions",
                      style: TextStyle(color: Colors.blue))),*/
              ],
              rows: state.reserv.map((HotelReservation) {
                return DataRow(cells: [
                  DataCell(Text(HotelReservation.userName)),
                  //DataCell(Text(HotelReservation.email)),
                  DataCell(Text(HotelReservation.phoneNumber)),
                  DataCell(Text(HotelReservation.roomType.roomType)),
                  DataCell(Text(HotelReservation.fromDay)),
                  DataCell(Text(HotelReservation.toDay)),

                  /*DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditHotelReservations();
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: const Color(0xFF064061),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: const Color(0xFF064061),
                        )),
                  ],
                ))*/
                ]);
              }).toList(),
            ),
          );
        } else {
          return Center(
            child: Text("Something went wrong please try again"),
          );
        }
      },
    );
  }
}

class HotelReservData {
  final String username;
  final String email;
  final String phone_num;
  final String room_type;
  final String from_day;
  final String to_day;

  final String paid;

  HotelReservData(this.username, this.email, this.phone_num, this.room_type,
      this.from_day, this.to_day, this.paid);
}
