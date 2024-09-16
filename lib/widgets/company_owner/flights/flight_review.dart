import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

import 'package:reserva/widgets/shared/edit_review.dart';

class FlightReviewsTable extends StatelessWidget {
  final List<FlightReview> data;
  FlightReviewsTable({super.key, required this.data});

  List<ReviewData> reviewDataList = [
    ReviewData('user one', 'it was a good experience'),
    ReviewData('user one', 'it was a good experience'),
    ReviewData('user one', 'it was a good experience'),
    ReviewData('user one', 'it was a good experience'),
    ReviewData('user one', 'it was a good experience'),
    ReviewData('user one', 'it was a good experience'),
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
            label: Text('User Name', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'User Name',
          ),
          DataColumn(
            label: Text('Review', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Review',
          ),
          /*DataColumn(
              label: Text("                           Actions",
                  style: TextStyle(color: Colors.blue))),*/
        ],
        rows: data.map((FlightReview) {
          return DataRow(cells: [
            DataCell(Text(FlightReview.userName)),
            DataCell(Text(FlightReview.review)),
            /* DataCell(Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditReview();
                        },
                      );
                    },
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
            ))*/
          ]);
        }).toList(),
      ),
    );
  }
}

class ReviewData {
  final String user_id;
  final String review;

  ReviewData(this.user_id, this.review);
}
