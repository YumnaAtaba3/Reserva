import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_room/cubit/add_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_room/cubit/edit_room_cubit.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

import 'package:reserva/widgets/company_owner/hotels/edit_room.dart';
import 'package:reserva/widgets/company_owner/hotels/room_slider.dart';

class RoomCard extends StatelessWidget {
  RoomCard({super.key, required this.data});
  final List<Room> data;
  List details = [
    {
      'beds': '3',
      'sleeps': '2',
      'features': 'sound proof',
      'type': 'deluxe twin room',
      'details':
          'we understand that family time is precious annd the best memories last forever when the stay is memorable. Our Premium Family Rooms have been designed with you in mind, offering a stay that promises to provide your family with unique moments',
      'price': '150\$'
    },
    {
      'beds': '3',
      'sleeps': ' 2',
      'features': 'safty',
      'type': 'connected room',
      'details': 'here is the room details',
      'price': '150\$'
    },
    {
      'beds': '3',
      'sleeps': '2',
      'features': 'water services',
      'type': 'non smoking room',
      'details': 'here is the room details',
      'price': '150\$'
    },
    {
      'beds': '3',
      'sleeps': '2',
      'features': 'sound proof',
      'type': 'single room',
      'details': 'here is the room details',
      'price': '150\$'
    },
    {
      'beds': '3',
      'sleeps': '2',
      'features': 'water services',
      'type': ' smoking room',
      'details': 'here is the room details',
      'price': '150\$'
    },
    {
      'beds': '3',
      'sleeps': '2',
      'features': 'sound proof',
      'type': 'deluxe triple room',
      'details': 'here is the room details',
      'price': '150\$'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Container(
            width: 400,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: RoomSlider(images: data[i].roomPhotos),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Details :',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF064061))),
                      Flexible(
                        child: Text(
                          data[i].details,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('Beds :',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF064061))),
                          Text(data[i].beds.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Sleeps :',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF064061))),
                          Text(data[i].sleeps.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('Feautures :',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF064061))),
                          for (int a = 0; a < data[i].roomFeatures.length; a++)
                            Text(data[i].roomFeatures[a].featureName + ",",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Type :',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF064061))),
                        Text(data[i].roomType.roomType,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<EditRoomCubit>(context)
                                .getAllRoomFeatures();
                            BlocProvider.of<EditRoomCubit>(context)
                                .getAllRoomTypes();

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditRoom(data: data[i]);
                              },
                            );
                          },
                          icon: Icon(Icons.edit, color: Color(0xFF064061))),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Price :',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text(data[i].priceForNight.toString() + r"$",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.blue)),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<ShowRoomCubit>(context)
                                .deleteRoom(id: data[i].id.toString());
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xFF064061),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
