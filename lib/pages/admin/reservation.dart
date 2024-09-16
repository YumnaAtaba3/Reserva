
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/reservation/reservation_cubit.dart';
import 'package:flutter/material.dart';

class reservePage extends StatelessWidget {

  @override
Widget build(BuildContext context) {
  final reservationCubit = BlocProvider.of<ReservationCubit>(context);
    reservationCubit.getTrips();
  return Scaffold(
    body: ListView(
      children: [
        Text(
          'Reservation',
          style: TextStyle(
            fontFamily: "DancingScript",
          color: Color(0xFF064061),
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        BlocBuilder<ReservationCubit, ReservationState>(
          builder: (context, state) {
            if (state is ReservationInitial) {
              return Center(
                child: Text('Press the refresh button to load Reservation Trip.'),
              );
            } else if (state is ReservationLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ReservationLoadedState) {
                final trips = state.trips;

              if (trips.isEmpty) {
                return Center(
                  child: Text('No Reservation found.'),
                );
              }

              return DataTable(
                  columnSpacing: 1.0,
                horizontalMargin: 10.0,
                decoration: BoxDecoration(
                //  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Trip Name',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'From Date',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'To Date',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'User Name',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Email',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Count of Passengers',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
          rows:trips.map((trip) => DataRow(
  cells: <DataCell>[
    DataCell(Text(trip.tripName)),
    DataCell(Text(trip.fromDate)),
    DataCell(Text(trip.toDate)),
    DataCell(Text(trip.userName)),
    DataCell(Text(trip.email)),
    DataCell(Text(trip.countOfPassenger.toString())), // Convert to String if needed
  ],
)).toList(),
        
    );
            } else if (state is ReservationErrorState) {
              return Center(
                child: Text(' ${state.errorMessage}'),
              );
            }
      else if (state is ReservationEmpty) {
              return Center(
                child: Text(' ${state.message}'),
              );
            }
            return Container();
          },
        ),
      ],
    ),
  );
}}



