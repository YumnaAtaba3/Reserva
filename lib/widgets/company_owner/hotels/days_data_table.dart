import 'package:flutter/material.dart';

class DaysDataTable extends StatefulWidget {
  const DaysDataTable({super.key});

  @override
  State<DaysDataTable> createState() => _DaysDataTableState();
}

class _DaysDataTableState extends State<DaysDataTable> {
  List<DayData> daysDataList = [
    DayData('day one', 'here is the first title', 'here is the details'),
    DayData('day one', 'here is the first title', 'here is the details'),
    DayData('day one', 'here is the first title', 'here is the details'),
    DayData('day one', 'here is the first title', 'here is the details'),
    DayData('day one', 'here is the first title', 'here is the details'),
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
            label: Text('Day-Num', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Name',
          ),
          DataColumn(
            label: Text('Title', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Location',
          ),
          DataColumn(
            label: Text('Details', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Payment',
          ),
          DataColumn(
              label: Text("                           Actions",
                  style: TextStyle(color: Colors.blue))),
        ],
        rows: daysDataList.map((DayData) {
          return DataRow(cells: [
            DataCell(Text(DayData.day_num)),
            DataCell(Text(DayData.title)),
            DataCell(Text(DayData.details)),
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

class DayData {
  final String day_num;
  final String title;
  final String details;

  DayData(this.day_num, this.title, this.details);
}
