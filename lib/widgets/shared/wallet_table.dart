import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/wallet.dart';

class WalletTable extends StatelessWidget {
  WalletTable({super.key, required this.data});
  final List<Activity> data;
  // List<DataObject> data = [
  //   DataObject('1', true, 5, 'capture', "2023-7-12"),
  //   DataObject('2', false, 3, 'withdrawal', "2023-7-12"),
  //   DataObject('3', true, 2, 'capture', "2023-7-12"),
  //   DataObject('4', false, 1, 'withdrawal', "2023-7-12"),
  //   DataObject('5', true, 4, 'capture', "2023-7-12"),
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 1.0, // Adjust the spacing between columns
        horizontalMargin: 10.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        columns: [
          DataColumn(
            label: Text(
              'ID',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'ID',
          ),
          DataColumn(
            label: Text(
              'Action',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'Action',
          ),
          DataColumn(
            label: Text(
              'Amount',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'Amount',
          ),
          DataColumn(
            label: Text(
              ' Transfer Type',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'Type',
          ),
          DataColumn(
            label: Text(
              'Date',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'Date',
          ),
        ],
        rows: data.map((Activity) {
          return DataRow(cells: [
            DataCell(Text(Activity.id.toString())),
            DataCell(
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Activity.action ? Icons.add : Icons.remove,
                  color: Activity.action ? Colors.green : Colors.red,
                ),
              ),
            ),
            DataCell(Text(Activity.amount.toString())),
            DataCell(Text(Activity.transfer_type)),
            DataCell(Text(Activity.date)),
          ]);
        }).toList(),
      ),
    );
  }
}

class DataObject {
  String id;
  bool action;
  int amount;

  String type;
  String date;
  DataObject(
    this.id,
    this.action,
    this.amount,
    this.type,
    this.date,
  );
}
