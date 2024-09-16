import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/widgets/company_owner/flights/add_flight_time.dart';
import 'package:reserva/widgets/company_owner/flights/edit_flight_time.dart';

class FlightsTimeTable extends StatelessWidget {
  FlightsTimeTable({
    super.key,
    required this.data,
    required this.data2,
    // required this.data3
  });
  final List<FlightTime> data;
  //final FlightTime data3;
  final int data2;
  List<FlightsTimeData> flightsTimeDataList = [
    FlightsTimeData('5:00 am', '12:00 pm', '\$300', '\$900', '12-5-2024'),
    FlightsTimeData('5:00 am', '12:00 pm', '\$300', '\$900', '12-5-2024'),
    FlightsTimeData('5:00 am', '12:00 pm', '\$300', '\$900', '12-5-2024'),
    FlightsTimeData('5:00 am', '12:00 pm', '\$300', '\$900', '12-5-2024'),
    FlightsTimeData('5:00 am', '12:00 pm', '\$300', '\$900', '12-5-2024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 1.0, // Adjust the spacing between columns
        horizontalMargin: 10.0, // Add horizontal margin around the table
        decoration: BoxDecoration(
        //  color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        columns: [
          DataColumn(
            label: Text('From Hour', style: TextStyle(color: Colors.blue)),
            numeric: false,
          ),
          DataColumn(
            label: Text('To Hour', style: TextStyle(color: Colors.blue)),
            numeric: false,
          ),
          DataColumn(
            label: Text('Adult Price', style: TextStyle(color: Colors.blue)),
            numeric: false,
          ),
          DataColumn(
            label: Text('Child Price', style: TextStyle(color: Colors.blue)),
            numeric: false,
          ),
          DataColumn(
            label: Text('Depart Day', style: TextStyle(color: Colors.blue)),
            numeric: false,
          ),
          DataColumn(
              label: Text("                    Actions",
                  style: TextStyle(color: Colors.blue))),
        ],
        rows: data.map((FlightsTime) {
          return DataRow(cells: [
            DataCell(Text(FlightsTime.fromHour)),
            DataCell(Text(FlightsTime.toHour)),
            DataCell(Text(FlightsTime.adultPrice.toString())),
            DataCell(Text(FlightsTime.childrenPrice.toString())),
            DataCell(Text(FlightsTime.departureDay.toString())),
            DataCell(Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddFlightTime(data: data2);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: const Color(0xFF064061),
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditFlightTime(data: FlightsTime);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: const Color(0xFF064061),
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ShowFlightCubit>(context)
                          .deleteFlightTime(id: FlightsTime.id.toString());
                    },
                    icon: Icon(
                      Icons.delete,
                      color: const Color(0xFF064061),
                    )),
              ],
            ))
          ]);
        }).toList(),
      ),
    );
  }
}

class FlightsTimeData {
  final String from_hour;
  final String to_hour;
  final String adult_price;
  final String child_price;

  final String depart_day;
  FlightsTimeData(this.from_hour, this.to_hour, this.adult_price,
      this.child_price, this.depart_day);
}
