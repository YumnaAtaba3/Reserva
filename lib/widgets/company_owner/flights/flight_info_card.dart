import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';

class FlightInfoCard extends StatelessWidget {
  FlightInfoCard({super.key, required this.data});
  final List<FlightInfo> data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 20,
      child: Container(
        //color: Colors.white,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Text("Name:",
                  style: TextStyle(
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(data[0].airwayName, style: TextStyle(fontSize: 16))
            ],
          ),
          SizedBox(
            width: 200,
          ),

          /*  SizedBox(
                width: 200,
              ),*/
          Row(
            children: [
              Text("City:",
                  style: TextStyle(
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(data[0].city.cityName, style: TextStyle(fontSize: 16))
            ],
          )
        ]),
      ),
    );
  }
}
