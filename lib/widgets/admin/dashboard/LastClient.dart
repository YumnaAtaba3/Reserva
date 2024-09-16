import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lastclient/lastclient_cubit.dart';

class Lastclient extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LastclientCubit>(context).showlastClients();
    return BlocBuilder<LastclientCubit, LastclientState>(
      builder: (context, state) {
        if (state is LastClientloading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is dashboardSuccessLastClient) {
          return DataTable(
            columnSpacing: 1.0,
            horizontalMargin: 10.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            columns: [
              DataColumn(
                label: Text('Name', style: TextStyle(color: Colors.blue)),
              ),
              DataColumn(
                label: Text('Email', style: TextStyle(color: Colors.blue)),
              ),
              DataColumn(
                label: Text('Phone Number', style: TextStyle(color: Colors.blue)),
              ),
              DataColumn(
                label: Text('Gender', style: TextStyle(color: Colors.blue)),
              ),
            ],
            rows: (state.client).map((client) {
              return DataRow(cells: [
                DataCell(Text(client.name ?? '')),
                DataCell(Text(client.email ?? '')),
                DataCell(Text(client.phone ?? '')),
                DataCell(Text(client.gender ?? '')),
              ]);
            }).toList(),
          );
        } else if (state is EmptyLastClient) {
          return Center(
            child: Text((state as EmptyLastClient).message),
          );
        } else if (state is  LastClientFailure) {
          return Center(
            child: Text((state as LastClientFailure).message),
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}