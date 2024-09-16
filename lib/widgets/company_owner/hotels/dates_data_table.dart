import 'package:flutter/material.dart';

class DatesDataTable extends StatefulWidget {
  const DatesDataTable({super.key});

  @override
  State<DatesDataTable> createState() => _DatesDataTableState();
}

class _DatesDataTableState extends State<DatesDataTable> {
  List<DateData> datesDataList = [
    DateData('\$1000', '5', '9-9-2024'),
    DateData('\$1000', '5', '9-9-2024'),
    DateData('\$1000', '5', '9-9-2024'),
    DateData('\$1000', '5', '9-9-2024'),
    DateData('\$1000', '5', '9-9-2024'),
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
            label: Text('Price', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Name',
          ),
          DataColumn(
            label:
                Text('Reserved-People', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Location',
          ),
          DataColumn(
            label: Text('Date', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Payment',
          ),
          DataColumn(
              label: Text("                          Actions",
                  style: TextStyle(color: Colors.blue))),
        ],
        rows: datesDataList.map((DateData) {
          return DataRow(cells: [
            DataCell(Text(DateData.price)),
            DataCell(Text(DateData.reserv_people)),
            DataCell(Text(DateData.date)),
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

class DateData {
  final String price;
  final String reserv_people;
  final String date;

  DateData(this.price, this.reserv_people, this.date);
}
