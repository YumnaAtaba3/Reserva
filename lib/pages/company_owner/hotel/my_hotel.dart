import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_info/cubit/add_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_room/cubit/add_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_hotel_photos/cubit/show_hotel_photos_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_hotel_photos/cubit/show_hotel_photos_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_info/cubit/show_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_info/cubit/show_hotel_info_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_state.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_facility/cubit/edit_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_info/cubit/edit_hotel_info_cubit.dart';

import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/widgets/company_owner/hotels/add_facility.dart';
import 'package:reserva/widgets/company_owner/hotels/add_hotel_photos.dart';

import 'package:reserva/widgets/company_owner/hotels/edit_facility.dart';
import 'package:reserva/widgets/company_owner/hotels/edit_hotel_info.dart';

import 'package:reserva/widgets/company_owner/hotels/image_grid.dart';
import 'package:reserva/widgets/company_owner/hotels/add_room.dart';
import 'package:reserva/widgets/company_owner/hotels/info_card.dart';

import 'package:reserva/widgets/company_owner/hotels/room_card.dart';

import 'package:reserva/widgets/company_owner/hotels/add_hotel_info.dart';
import 'package:reserva/widgets/shared/reviews_table.dart';

class MyHotel extends StatelessWidget {
  MyHotel({super.key});

  bool wifi = false;

  bool meals = false;

  bool parking = false;

  bool childActiv = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyHotelCubit>(context).getAllMyHotel();
    BlocProvider.of<ShowHotelInfoCubit>(context).showHotelInfo();
    BlocProvider.of<ShowFacilityCubit>(context).getAllFacilities();
    BlocProvider.of<ShowHotelPhotosCubit>(context).showHotelPhotos();
    BlocProvider.of<ShowRoomCubit>(context).showHotelRooms();
    //  BlocProvider.of<MyHotelCubit>(context).showHotelInfo();
    // BlocProvider.of<MyHotelCubit>(context).showHotelFacility();
    // BlocProvider.of<MyHotelCubit>(context).showHotelPhotos();
    // BlocProvider.of<RoomCubit>(context).showHotelRooms();
    //BlocProvider.of<MyHotelCubit>(context).showHotelReview();
    return BlocBuilder<MyHotelCubit, MyHotelState>(
      builder: (context, state) {
        if (state is MyHotelLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MyHotelFailure) {
          return Center(
            child: Text("Something went wrong please try again"),
          );
        }
        return Scaffold(
          body: ListView(children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Hotel Details :",
                style: TextStyle(
                    color: const Color(0xFF065061),
                    fontSize: 60,
                    fontFamily: "DancingScript",
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              BlocBuilder<ShowHotelInfoCubit, ShowHotelInfoState>(
                builder: (context, state) {
                  if (state is ShowHotelInfoSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        state.hotelInfo[0].stars,
                        (_) => Icon(
                          Icons.star,
                          color: const Color(0xFF065061),
                          size: 50,
                        ),
                      ),
                    );
                  } else if (state is MyHotelEmpty) {
                    return Center(
                      child: Container(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Information:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<AddHotelInfoCubit>(context)
                                    .getFilters();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddHotelInfo();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                    ),
                    BlocBuilder<ShowHotelInfoCubit, ShowHotelInfoState>(
                      builder: (context, state) {
                        if (state is ShowHotelInfoLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ShowHotelInfoSuccess) {
                          return Expanded(
                              child: HotelInfoCard(
                            data: state.hotelInfo,
                          ));
                        } else if (state is ShowHotelInfoEmpty) {
                          return Center(
                            child: Container(
                              child: Text(
                                  'There is no information , please add you hotel information'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<EditHotelInfoCubit>(context)
                                  .getFilters();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditHotelInfo(
                                      data: BlocProvider.of<ShowHotelInfoCubit>(
                                              context)
                                          .hotelInfo!);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Facilities:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddFacility();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                    ),
                    BlocBuilder<ShowFacilityCubit, ShowFacilityState>(
                      builder: (context, state) {
                        if (state is ShowFacilityLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ShowFacilitySuccess) {
                          return Expanded(
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i <
                                        BlocProvider.of<ShowFacilityCubit>(
                                                context)
                                            .facilities
                                            .length;
                                    i++)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        // SizedBox(width: 100),
                                        Checkbox(
                                          value: BlocProvider.of<
                                                  ShowFacilityCubit>(context)
                                              .facilities[i]
                                              .enabled,
                                          activeColor: Colors.blue,
                                          onChanged: (val) {
                                            // BlocProvider.of<EditFacilityCubit>(
                                            //         context)
                                            //     .ChangeFacility(
                                            //         id: state.facility[i].id,
                                            //         facility_name: state
                                            //             .facility[i]
                                            //             .facilityName,
                                            //         enabled: val!,
                                            //         context: context);
                                            // BlocProvider.of<EditFacilityCubit>(
                                            //         context)
                                            //     .ChangeFacility(
                                            //   id: state.facility[i].id,
                                            //   facility_name: state
                                            //       .facility[i].facilityName,
                                            //   enabled:
                                            //       state.facility[i].enabled,
                                            // );
                                            BlocProvider.of<EditFacilityCubit>(
                                                    context)
                                                .ChangeFacility(
                                                    id: BlocProvider.of<
                                                                ShowFacilityCubit>(
                                                            context)
                                                        .facilities[i]
                                                        .id,
                                                    facility_name: BlocProvider
                                                            .of<ShowFacilityCubit>(
                                                                context)
                                                        .facilities[i]
                                                        .facilityName,
                                                    enabled: val!,
                                                    context: context);
                                            BlocProvider.of<ShowFacilityCubit>(
                                                    context)
                                                .getAllFacilities();
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            BlocProvider.of<ShowFacilityCubit>(
                                                    context)
                                                .facilities[i]
                                                .facilityName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        //SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        } else if (state is ShowFacilityEmpty) {
                          return Center(
                            child: Container(
                              child: Text('There is no Facilities'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    /*Expanded(
                        child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                        ),
                        Checkbox(
                            value: state.facility[0].enabled,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              // setState(() {
                              //   wifi = val!;
                              // });
                            }),
                        Text(
                          state.facility[0].facilityName,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Checkbox(
                            value: state.facility[1].enabled,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              // setState(() {
                              //   meals = val!;
                              // });
                            }),
                        Text(
                          state.facility[1].facilityName,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Checkbox(
                            value: state.facility[2].enabled,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              // setState(() {
                              //   parking = val!;
                              // });
                            }),
                        Text(
                          state.facility[2].facilityName,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Checkbox(
                            value: state.facility[3].enabled,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              // setState(() {
                              //   childActiv = val!;
                              // });
                            }),
                        Text(
                          state.facility[3].facilityName,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    )),*/
                    /*Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              // BlocProvider.of<MyHotelCubit>(context)
                              //     .showHotelFacility();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditFacility();
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                      ],
                    )*/
                    Container(),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Photos:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddPhotos();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                    ),
                    BlocBuilder<ShowHotelPhotosCubit, ShowHotelPhotosState>(
                      builder: (context, state) {
                        if (state is ShowHotelPhotosLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ShowHotelPhotosSuccess) {
                          return Expanded(
                              child: ImagesGrid(
                            data: state.photos,
                          ));
                        } else if (state is ShowHotelPhotosEmpty) {
                          return Center(
                            child: Container(
                              child: Text('There is no hotel photos'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<ShowHotelPhotosCubit>(context)
                              .deleteAllPhotos();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rooms:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<AddRoomCubit>(context)
                                    .getAllRoomFeatures();
                                BlocProvider.of<AddRoomCubit>(context)
                                    .getAllRoomTypes();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddRoom();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                    ),
                    BlocBuilder<ShowRoomCubit, ShowRoomState>(
                      builder: (context, state) {
                        if (state is ShowRoomLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ShowRoomSuccess) {
                          return Expanded(
                            child: RoomCard(data: state.rooms),
                          );
                        } else if (state is ShowRoomEmpty) {
                          return Center(
                            child: Container(
                              child: Text('There is no rooms'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<ShowRoomCubit>(context)
                              .deleteAllRooms();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reviews:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<MyHotelCubit, MyHotelState>(
                      builder: (context, state) {
                        if (state is MyHotelSuccess) {
                          return Expanded(
                              child: ReviewsTable(data: state.hotelReview));
                        } else if (state is MyHotelEmpty) {
                          return Center(
                            child: Container(
                              child: Text(
                                'There is no reviews',
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Container(),
                  ],
                ),
              ),
            ])
          ]),
        );
      },
    );
  }
}


    /*return BlocBuilder<MyHotelCubit, MyHotelState>(
      builder: (context, state) {
        if (state is MyHotelLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MyHotelSuccessHotelPhotos) {
          return Scaffold(
            body: ListView(children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Hotel Details :",
                  style: TextStyle(
                      color: const Color(0xFF065061),
                      fontSize: 60,
                      fontFamily: "DancingScript",
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    //state.hotelInfo[0].stars,
                    5,
                    (_) => Icon(
                      Icons.star,
                      color: const Color(0xFF065061),
                      size: 50,
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Information:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddHotelInfo();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                      Expanded(child: Container()
                          //      HotelInfoCard(
                          //   data: state.hotelInfo,
                          // )
                          ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditHotelInfo();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Facilities:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddFacility();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                      /* Expanded(
                       child: Row(
                     children: [
                       SizedBox(
                         width: 100,
                       ),
                       Checkbox(
                           value: state.facility[0].enabled,
                           activeColor: Colors.blue,
                           onChanged: (val) {
                             // setState(() {
                             //   wifi = val!;
                             // });
                           }),
                       Text(
                         state.facility[0].facilityName,
                         style: TextStyle(color: Colors.black, fontSize: 16),
                       ),
                       SizedBox(
                         width: 100,
                       ),
                       Checkbox(
                           value: state.facility[1].enabled,
                           activeColor: Colors.blue,
                           onChanged: (val) {
                             // setState(() {
                             //   meals = val!;
                             // });
                           }),
                       Text(
                         state.facility[1].facilityName,
                         style: TextStyle(color: Colors.black, fontSize: 16),
                       ),
                       SizedBox(
                         width: 100,
                       ),
                       Checkbox(
                           value: state.facility[2].enabled,
                           activeColor: Colors.blue,
                           onChanged: (val) {
                             // setState(() {
                             //   parking = val!;
                             // });
                           }),
                       Text(
                         state.facility[2].facilityName,
                         style: TextStyle(color: Colors.black, fontSize: 16),
                       ),
                       SizedBox(
                         width: 100,
                       ),
                       Checkbox(
                           value: state.facility[3].enabled,
                           activeColor: Colors.blue,
                           onChanged: (val) {
                             // setState(() {
                             //   childActiv = val!;
                             // });
                           }),
                       Text(
                         state.facility[3].facilityName,
                         style: TextStyle(color: Colors.black, fontSize: 16),
                       ),
                     ],
                   )),*/
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditFacility();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Photos:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddPhotos();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                          //child:
                          //  Container(),
                          child: ImagesGrid(
                        data: state.photos,
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rooms:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddRoom();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                      Expanded(child: Container()
                          // RoomCard(data: state.rooms),
                          ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reviews:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()
                          //  ReviewsTable(data: state.hotelReview)
                          ),
                    ],
                  ),
                ),
              ])
            ]),
          );
        } else if (state is MyHotelEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        } else if (state is MyHotelFailure) {
          return Center(
            child: Text("Something went wrong please try again"),
          );
        } else {
          return Text("Something is wrong");
        }
      },
    );*/

    // return BlocBuilder<MyHotelCubit, MyHotelState>(builder: (context, state) {
    //   if (state is MyHotelLoading) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   } else if (state is MyHotelFailure) {
    //     return Center(
    //       child: Text("Something went wrong please try again"),
    //     );
    //   } else {}

    //   return Scaffold(
    //     body: ListView(children: [
    //       Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    //         Text(
    //           "Hotel Details :",
    //           style: TextStyle(
    //               color: const Color(0xFF065061),
    //               fontSize: 60,
    //               fontFamily: "DancingScript",
    //               fontWeight: FontWeight.bold),
    //           textAlign: TextAlign.center,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: List.generate(
    //             //state.hotelInfo[0].stars,
    //             5,
    //             (_) => Icon(
    //               Icons.star,
    //               color: const Color(0xFF065061),
    //               size: 50,
    //             ),
    //           ),
    //         ),
    //         Card(
    //           elevation: 2,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Information:",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     IconButton(
    //                         onPressed: () {
    //                           showDialog(
    //                             context: context,
    //                             builder: (BuildContext context) {
    //                               return AddHotelInfo();
    //                             },
    //                           );
    //                         },
    //                         icon: Icon(
    //                           Icons.add,
    //                           color: Colors.blue,
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //               Expanded(child: BlocBuilder<MyHotelCubit, MyHotelState>(
    //                 builder: (context, state) {
    //                   if (state is MyHotelSuccessInfo) {
    //                     return Expanded(
    //                         child: HotelInfoCard(data: state.hotelInfo));
    //                   } else if (state is MyHotelEmpty) {
    //                     return Container(
    //                       child: Text(state.message),
    //                     );
    //                   }
    //                   return Container();
    //                 },
    //               )
    //                   //      HotelInfoCard(
    //                   //   data: state.hotelInfo,
    //                   // )
    //                   ),
    //               Row(
    //                 children: [
    //                   IconButton(
    //                       onPressed: () {
    //                         showDialog(
    //                           context: context,
    //                           builder: (BuildContext context) {
    //                             return EditHotelInfo();
    //                           },
    //                         );
    //                       },
    //                       icon: Icon(
    //                         Icons.edit,
    //                         color: Colors.blue,
    //                       )),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //         /*Card(
    //           elevation: 2,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(15),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Facilities:",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     IconButton(
    //                         onPressed: () {
    //                           showDialog(
    //                             context: context,
    //                             builder: (BuildContext context) {
    //                               return AddFacility();
    //                             },
    //                           );
    //                         },
    //                         icon: Icon(
    //                           Icons.add,
    //                           color: Colors.blue,
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                   child: Row(
    //                 children: [
    //                   SizedBox(
    //                     width: 100,
    //                   ),
    //                   Checkbox(
    //                       value: state.facility[0].enabled,
    //                       activeColor: Colors.blue,
    //                       onChanged: (val) {
    //                         // setState(() {
    //                         //   wifi = val!;
    //                         // });
    //                       }),
    //                   Text(
    //                     state.facility[0].facilityName,
    //                     style: TextStyle(color: Colors.black, fontSize: 16),
    //                   ),
    //                   SizedBox(
    //                     width: 100,
    //                   ),
    //                   Checkbox(
    //                       value: state.facility[1].enabled,
    //                       activeColor: Colors.blue,
    //                       onChanged: (val) {
    //                         // setState(() {
    //                         //   meals = val!;
    //                         // });
    //                       }),
    //                   Text(
    //                     state.facility[1].facilityName,
    //                     style: TextStyle(color: Colors.black, fontSize: 16),
    //                   ),
    //                   SizedBox(
    //                     width: 100,
    //                   ),
    //                   Checkbox(
    //                       value: state.facility[2].enabled,
    //                       activeColor: Colors.blue,
    //                       onChanged: (val) {
    //                         // setState(() {
    //                         //   parking = val!;
    //                         // });
    //                       }),
    //                   Text(
    //                     state.facility[2].facilityName,
    //                     style: TextStyle(color: Colors.black, fontSize: 16),
    //                   ),
    //                   SizedBox(
    //                     width: 100,
    //                   ),
    //                   Checkbox(
    //                       value: state.facility[3].enabled,
    //                       activeColor: Colors.blue,
    //                       onChanged: (val) {
    //                         // setState(() {
    //                         //   childActiv = val!;
    //                         // });
    //                       }),
    //                   Text(
    //                     state.facility[3].facilityName,
    //                     style: TextStyle(color: Colors.black, fontSize: 16),
    //                   ),
    //                 ],
    //               )),
    //               Row(
    //                 children: [
    //                   IconButton(
    //                       onPressed: () {
    //                         showDialog(
    //                           context: context,
    //                           builder: (BuildContext context) {
    //                             return EditFacility();
    //                           },
    //                         );
    //                       },
    //                       icon: Icon(
    //                         Icons.edit,
    //                         color: Colors.blue,
    //                       )),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),*/
    //         Card(
    //           elevation: 2,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Photos:",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     IconButton(
    //                         onPressed: () {
    //                           showDialog(
    //                             context: context,
    //                             builder: (BuildContext context) {
    //                               return AddPhotos();
    //                             },
    //                           );
    //                         },
    //                         icon: Icon(
    //                           Icons.add,
    //                           color: Colors.blue,
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //               Expanded(child: ImagesGrid()),
    //               IconButton(
    //                   onPressed: () {},
    //                   icon: Icon(
    //                     Icons.delete,
    //                     color: Colors.blue,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         Card(
    //           elevation: 2,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Rooms:",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     IconButton(
    //                         onPressed: () {
    //                           showDialog(
    //                             context: context,
    //                             builder: (BuildContext context) {
    //                               return AddRoom();
    //                             },
    //                           );
    //                         },
    //                         icon: Icon(
    //                           Icons.add,
    //                           color: Colors.blue,
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                 child: RoomCard(),
    //               ),
    //               IconButton(
    //                   onPressed: () {},
    //                   icon: Icon(
    //                     Icons.delete,
    //                     color: Colors.blue,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         Card(
    //           elevation: 2,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Reviews:",
    //                       style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     /*IconButton(
    //                           onPressed: () {},
    //                           icon: Icon(
    //                             Icons.add,
    //                             color: Colors.blue,
    //                           ))*/
    //                   ],
    //                 ),
    //               ),
    //               Expanded(child: Container()
    //                   //  ReviewsTable(data: state.hotelReview)
    //                   ),
    //               IconButton(
    //                   onPressed: () {},
    //                   icon: Icon(
    //                     Icons.delete,
    //                     color: Colors.blue,
    //                   ))
    //             ],
    //           ),
    //         ),
    //       ])
    //     ]),
    //   );
    // });
 