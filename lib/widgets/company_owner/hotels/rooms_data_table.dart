import 'package:flutter/material.dart';

class RoomsDataTable extends StatefulWidget {
  const RoomsDataTable({super.key});

  @override
  State<RoomsDataTable> createState() => _RoomsDataTableState();
}

class _RoomsDataTableState extends State<RoomsDataTable> {
  List<RoomData> roomsDataList = [
    RoomData(
        num: '2',
        priceOfNight: '\$300',
        beds: '2',
        type: 'bussiness',
        details: 'its a classy and modern room',
        sleeps: '4',
        feautures: 'internet & hot water '),
    RoomData(
        num: '2',
        priceOfNight: '\$300',
        beds: '2',
        type: 'bussiness',
        details: 'its a classy and modern room',
        sleeps: '4',
        feautures: 'internet & hot water '),
    RoomData(
        num: '2',
        priceOfNight: '\$300',
        beds: '2',
        type: 'bussiness',
        details: 'its a classy and modern room',
        sleeps: '4',
        feautures: 'internet & hot water '),
    RoomData(
        num: '2',
        priceOfNight: '\$300',
        beds: '2',
        type: 'bussiness',
        details: 'its a classy and modern room',
        sleeps: '4',
        feautures: 'internet & hot water '),
    RoomData(
        num: '2',
        priceOfNight: '\$300',
        beds: '2',
        type: 'bussiness',
        details: 'its a classy and modern room',
        sleeps: '4',
        feautures: 'internet & hot water '),
    RoomData(
        num: '2',
        priceOfNight: '\$300',
        beds: '2',
        type: 'bussiness',
        details: 'its a classy and modern room',
        sleeps: '4',
        feautures: 'internet & hot water '),
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
            label: Text('Num', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Name',
          ),
          DataColumn(
            label: Text('PriceOfNight', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Location',
          ),
          DataColumn(
            label: Text('Beds', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Payment',
          ),
          DataColumn(
            label: Text('Type', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Number of Rooms',
          ),
          DataColumn(
            label: Text(
              '          Details',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
            label: Text(
              'Sleeps',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
            label: Text(
              'Features',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
              label: Text("               Actions",
                  style: TextStyle(color: Colors.blue))),
        ],
        rows: roomsDataList.map((RoomData) {
          return DataRow(cells: [
            DataCell(Text(RoomData.num)),
            DataCell(Text(RoomData.priceOfNight)),
            DataCell(Text(RoomData.beds)),
            DataCell(Text(RoomData.type)),
            DataCell(Text(RoomData.details)),
            DataCell(Text(RoomData.sleeps)),
            DataCell(Text(RoomData.feautures)),
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

class RoomData {
  final String num;
  final String priceOfNight;
  final String beds;
  final String type;
  final String details;
  final String sleeps;
  final String feautures;

  RoomData(
      {required this.num,
      required this.priceOfNight,
      required this.beds,
      required this.type,
      required this.details,
      required this.sleeps,
      required this.feautures});
}
