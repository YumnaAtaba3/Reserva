import 'package:flutter/material.dart';

class HotelDataTable extends StatefulWidget {
  const HotelDataTable({super.key});

  @override
  State<HotelDataTable> createState() => _HotelDataTableState();
}

class _HotelDataTableState extends State<HotelDataTable> {
  List<HotelData> hotelDataList = [
    HotelData('hotel one', 'Egypt - Cairo', '\$50', '3', '3'),
    HotelData('hotel two', 'Egypt - Giza', '\$30', '3', '3'),
    HotelData('hotel three', 'Dubai', '\$90', '2', '3'),
    HotelData('hotel four', 'France', '\$50', '3', '5'),
    HotelData('hotel five', 'USA', '\$100', '6', '3'),
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
            label: Text('Hotel', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Name',
          ),
          DataColumn(
            label: Text('Hotel Location', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Hotel Location',
          ),
          DataColumn(
            label: Text('Payment', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Payment',
          ),
          DataColumn(
            label:
                Text('Number of Rooms', style: TextStyle(color: Colors.blue)),
            numeric: false,
            tooltip: 'Number of Rooms',
          ),
          DataColumn(
            label: Text(
              'Number of Individuals',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
          DataColumn(
            label: Text(
              '                 Actions   ',
              style: TextStyle(color: Colors.blue),
            ),
            numeric: false,
            tooltip: 'Number of Individuals',
          ),
        ],
        rows: hotelDataList.map((hotelData) {
          return DataRow(cells: [
            DataCell(Text(hotelData.hotelName)),
            DataCell(Text(hotelData.hotelLocation)),
            DataCell(Text(hotelData.payment)),
            DataCell(Text(hotelData.numOfRooms)),
            DataCell(Text(hotelData.numOfIndividuals)),
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
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: const Color(0xFF064061),
                    ))
              ],
            ))
          ]);
        }).toList(),
      ),
    );
  }
}

class HotelData {
  final String hotelName;
  final String hotelLocation;
  final String payment;
  final String numOfRooms;
  final String numOfIndividuals;

  HotelData(this.hotelName, this.hotelLocation, this.payment, this.numOfRooms,
      this.numOfIndividuals);
}


 /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffF7F2F9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Color(0xFF064061),
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffF7F2F9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Color(0xFF064061),
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffF7F2F9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Color(0xFF064061),
                            ),
                            Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ],
                ),
              )*/
