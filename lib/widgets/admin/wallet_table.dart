// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:reserva/models/admin/wallet_model.dart';

class wallet_table extends StatelessWidget {
   final List<Activity> data;
  wallet_table({super.key,required this.data});

    @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 1.0, // Adjust the spacing between columns
        horizontalMargin: 10.0,
        decoration: BoxDecoration(
      //    color: Colors.white,
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
            DataCell(Text(Activity.transferType)),
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
  String date;
  String type;

  DataObject(this.id, this.action, this.amount, this.date, this.type);
}