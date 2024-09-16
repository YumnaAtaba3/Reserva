import 'package:flutter/material.dart';

class OffersDataTable extends StatefulWidget {
  const OffersDataTable({super.key});

  @override
  State<OffersDataTable> createState() => _OffersDataTableState();
}

class _OffersDataTableState extends State<OffersDataTable> {
  List<OfferData> offersDataList = [
    OfferData('1', '30%', '2-3-2024'),
    OfferData('1', '30%', '2-3-2024'),
    OfferData('1', '30%', '2-3-2024'),
    OfferData('1', '30%', '2-3-2024'),
    OfferData('1', '30%', '2-3-2024'),
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
            label: Text('ID', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Name',
          ),
          DataColumn(
            label:
                Text('Percentage-Offer', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Location',
          ),
          DataColumn(
            label: Text('Offer-End', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Payment',
          ),
          DataColumn(
              label: Text("                         Actions",
                  style: TextStyle(color: Colors.blue))),
        ],
        rows: offersDataList.map((OfferData) {
          return DataRow(cells: [
            DataCell(Text(OfferData.id)),
            DataCell(Text(OfferData.per_off)),
            DataCell(Text(OfferData.off_end)),
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

class OfferData {
  final String id;
  final String per_off;
  final String off_end;

  OfferData(this.id, this.per_off, this.off_end);
}
