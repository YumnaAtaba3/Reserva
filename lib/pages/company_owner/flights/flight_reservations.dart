import 'package:flutter/material.dart';
import 'package:reserva/widgets/company_owner/flights/flights_reservations.dart';

class FlightReservations extends StatefulWidget {
  const FlightReservations({super.key});

  @override
  State<FlightReservations> createState() => _FlightReservationsState();
}

class _FlightReservationsState extends State<FlightReservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text(
            'Reservations',
            style: TextStyle(
                color: const Color(0xFF064061),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),*/
        body: ListView(children: [
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Reservations :',
            style: TextStyle(
                color: const Color(0xFF064061),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 850,
          ),
          /*FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          )*/
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 10,
          ),
          FlightReservationTable()
        ],
      )
    ]));
  }
}
