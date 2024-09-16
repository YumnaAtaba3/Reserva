import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lastattraction/lastattraction_cubit.dart';

class lastattraction extends StatelessWidget {
  const lastattraction({super.key});

  @override
  Widget build(BuildContext context) {
   BlocProvider.of<LastattractionCubit>(context).showlastattractions();
    return BlocBuilder<LastattractionCubit, LastattractionState>(
      builder: (context, state) {
        if (state is LastAttractionloading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is dashboardSuccessLastAttraction) {
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
                            label: Text('Attraction Name', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('City', style: TextStyle(color: Colors.blue)),
                          ),
                          DataColumn(
                            label: Text('Attraction Type', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                        rows: 
                        (state.Attraction).map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.attractionName ?? '')),
                            DataCell(Text(data.city ?? '')),
                            DataCell(Text(data.attractionType ?? '')),
                          ]);
                        }).toList() 
                      );
        } else if (state is EmptyLastAttraction) {
          return Center(
            child: Text((state as EmptyLastAttraction).message),
          );
        } else if (state is  LastAttractionFailure) {
          return Center(
            child: Text((state as  LastAttractionFailure).message),
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