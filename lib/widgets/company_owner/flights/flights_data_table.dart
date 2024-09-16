import 'package:flutter/material.dart';

class FlightsTable extends StatefulWidget {
  const FlightsTable({super.key});

  @override
  State<FlightsTable> createState() => _FlightsTableState();
}

class _FlightsTableState extends State<FlightsTable> {
  List<FlightsData> flightsDataList = [
    FlightsData('2', 'true', 'false', 'bussiness class ', 'first class',
        'Damascus', 'Rome'),
    FlightsData('2', 'true', 'false', 'bussiness class ', 'first class',
        'Damascus', 'Rome'),
    FlightsData('2', 'true', 'false', 'bussiness class ', 'first class',
        'Damascus', 'Rome'),
    FlightsData('2', 'true', 'false', 'bussiness class ', 'first class',
        'Damascus', 'Rome'),
    FlightsData('2', 'true', 'false', 'bussiness class ', 'first class',
        'Damascus', 'Rome'),
    FlightsData('2', 'true', 'false', 'bussiness class ', 'first class',
        'Damascus', 'Rome'),
  ];
  @override
  Widget build(BuildContext context) {
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
            label: Text('Seats Num', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Name',
          ),
          DataColumn(
            label: Text('Hand Bag', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Location',
          ),
          DataColumn(
            label: Text('Checked Bag', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Payment',
          ),
          DataColumn(
            label: Text('Flight Class', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Number of Rooms',
          ),
          DataColumn(
            label: Text(
              'Seat Selection',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
            label: Text(
              'From-City',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
            label: Text(
              'To-City',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
              label: Text("               Actions",
                  style: TextStyle(color: Colors.blue))),
        ],
        rows: flightsDataList.map((FlightsData) {
          return DataRow(cells: [
            DataCell(Text(FlightsData.seats_num)),
            DataCell(Text(FlightsData.hand_bag)),
            DataCell(Text(FlightsData.checkes_bag)),
            DataCell(Text(FlightsData.flight_class)),
            DataCell(Text(FlightsData.seat_selection)),
            DataCell(Text(FlightsData.from_city)),
            DataCell(Text(FlightsData.to_city)),
            DataCell(Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
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
            ))
          ]);
        }).toList(),
      ),
    );
  }
}

class FlightsData {
  final String seats_num;
  final String hand_bag;
  final String checkes_bag;
  final String flight_class;
  final String seat_selection;
  final String from_city;
  final String to_city;

  FlightsData(this.seats_num, this.hand_bag, this.checkes_bag,
      this.flight_class, this.seat_selection, this.from_city, this.to_city);
}
