import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/flight_reservation/cubit/flight_reservations_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/flight_reservation/cubit/flight_reservations_state.dart';
import 'package:reserva/widgets/company_owner/flights/edit_flight_reservations.dart';

class FlightReservationTable extends StatelessWidget {
  FlightReservationTable({super.key});

  List<FlightReservData> flightReservDataList = [
    FlightReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'first class',
        'Damascus', 'Paris', '3-4-2024', '3', '2', 'true'),
    FlightReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'first class',
        'Damascus', 'Paris', '3-4-2024', '3', '2', 'true'),
    FlightReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'first class',
        'Damascus', 'Paris', '3-4-2024', '3', '2', 'true'),
    FlightReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'first class',
        'Damascus', 'Paris', '3-4-2024', '3', '2', 'true'),
    FlightReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'first class',
        'Damascus', 'Paris', '3-4-2024', '3', '2', 'true'),
    FlightReservData('ahmad', 'ahamd@gmail.com', '0964524157', 'first class',
        'Damascus', 'Paris', '3-4-2024', '3', '2', 'true'),
  ];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FlightReservationsCubit>(context).showFlightReserv();
    return BlocBuilder<FlightReservationsCubit, FlightReservationsState>(
      builder: (context, state) {
        if (state is FlightReservationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FlightReservationsFailure) {
          return Center(
              child: Container(
            child: Text(state.message.toString()),
          ));
        }
        if (state is FlightReservationsEmpty) {
          return Center(
              child: Container(
            child: Text(state.message.toString()),
          ));
        }
        if (state is FlightReservationsSuccess) {
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
                DataColumn(
                  label: Text('          Email',
                      style: TextStyle(color: Colors.blue)),
                  numeric: false,
                  tooltip: 'Email',
                ),
                DataColumn(
                  label: Text('Phone number',
                      style: TextStyle(color: Colors.blue)),
                  numeric: false,
                  tooltip: 'Phone number',
                ),
                DataColumn(
                  label: Text(
                    'From-City',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'From-City',
                ),
                DataColumn(
                  label: Text(
                    'To-City',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'To-City',
                ),
                DataColumn(
                  label: Text(
                    'Depart-Day',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'Depart-Day',
                ),
                DataColumn(
                  label: Text(
                    'Adults-Num',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'Adults-Num',
                ),
                DataColumn(
                  label: Text(
                    'Child-Num',
                    style: TextStyle(color: Colors.blue),
                  ),
                  numeric: false,
                  tooltip: 'Child-Num',
                ),

                /*DataColumn(
                  label: Text("               Actions",
                      style: TextStyle(color: Colors.blue))),*/
              ],
              rows: state.reserv.map((FlightReservation) {
                return DataRow(cells: [
                  DataCell(Text(FlightReservation.userName)),
                  DataCell(Text(FlightReservation.email)),
                  DataCell(Text(FlightReservation.phoneNumber)),
                  DataCell(Text(FlightReservation.fromCity.cityName)),
                  DataCell(Text(FlightReservation.toCity.cityName)),
                  DataCell(Text(FlightReservation.departDay)),
                  DataCell(Text(FlightReservation.adultsNum.toString())),
                  DataCell(Text(FlightReservation.childNum.toString())),

                  /* DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditFlightReservations();
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

class FlightReservData {
  final String username;
  final String email;
  final String phone_num;
  final String flight_class;
  final String from_city;
  final String to_city;
  final String depart_day;
  final String adults_num;
  final String child_num;
  final String paid;

  FlightReservData(
      this.username,
      this.email,
      this.phone_num,
      this.flight_class,
      this.from_city,
      this.to_city,
      this.depart_day,
      this.adults_num,
      this.child_num,
      this.paid);
}
