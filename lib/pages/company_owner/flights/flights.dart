import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_info/cubit/add_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/my_flight/cubit/my_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/my_flight/cubit/my_flight_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_info/cubit/show_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_info/cubit/show_flight_info_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_service/cubit/show_service_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_service/cubit/show_service_state.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_info/cubit/edit_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_service/cubit/edit_service_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_cubit.dart';
import 'package:reserva/widgets/company_owner/flights/add_flight.dart';

import 'package:reserva/widgets/company_owner/flights/add_flight_info.dart';
import 'package:reserva/widgets/company_owner/flights/add_service.dart';
import 'package:reserva/widgets/company_owner/flights/edit_info.dart';
import 'package:reserva/widgets/company_owner/flights/edit_service.dart';
import 'package:reserva/widgets/company_owner/flights/flight_info_card.dart';
import 'package:reserva/widgets/company_owner/flights/flight_review.dart';
import 'package:reserva/widgets/company_owner/flights/flight_ticket.dart';

import 'package:reserva/widgets/shared/reviews_table.dart';

class FlightsPage extends StatelessWidget {
  FlightsPage({super.key});

  bool pillow = false;

  bool meals = false;

  bool blanket = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyFlightCubit>(context).getAllMyFlight();
    BlocProvider.of<ShowFlightInfoCubit>(context).showFlightInfo();
    BlocProvider.of<ShowServiceCubit>(context).getAllServices();
    BlocProvider.of<ShowFlightCubit>(context).showFlights();
    // BlocProvider.of<MyFlightCubit>(context).showFlightService();
    //BlocProvider.of<MyFlightCubit>(context).showFlights();
    // BlocProvider.of<MyFlightCubit>(context).showFlightReview();
    return BlocBuilder<MyFlightCubit, MyFlightState>(
      builder: (context, state) {
        if (state is MyFlightLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MyFlightFailure) {
          return Center(
            child: Text("Something went wrong please try again"),
          );
        }
        return Scaffold(
          body: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flight_takeoff_outlined,
                        size: 70,
                       // color: Color(0xFF065061),
                      ),
                      Text(
                        " Airway Details :",
                        style: TextStyle(
                          //  color: const Color(0xFF065061),
                            fontSize: 60,
                            fontFamily: "DancingScript",
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
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
                                   // color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AddFlightInfoCubit>(context)
                                        .getFilters();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddFlightInfo();
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
                        BlocBuilder<ShowFlightInfoCubit, ShowFlightInfoState>(
                          builder: (context, state) {
                            if (state is ShowFlightInfoLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ShowFlightInfoSuccess) {
                              return Expanded(
                                  child:
                                      FlightInfoCard(data: state.flightInfo));
                            } else if (state is ShowFlightInfoEmpty) {
                              return Center(
                                child: Container(
                                  child: Text(
                                      'There is no information , please add you airway information'),
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
                                  BlocProvider.of<EditFlightInfoCubit>(context)
                                      .getFilters();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditFlightInfo(
                                          data: BlocProvider.of<
                                                  ShowFlightInfoCubit>(context)
                                              .flightInfo!);
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
                                "Services:",
                                style: TextStyle(
                                  //  color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddService();
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
                        BlocBuilder<ShowServiceCubit, ShowServiceState>(
                          builder: (context, state) {
                            if (state is ShowServiceLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ShowServiceSuccess) {
                              return Expanded(
                                child: Row(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            BlocProvider.of<ShowServiceCubit>(
                                                    context)
                                                .services
                                                .length;
                                        i++)
                                      Expanded(
                                        child: Row(
                                          children: [
                                            // SizedBox(width: 100),
                                            Checkbox(
                                              value: BlocProvider.of<
                                                      ShowServiceCubit>(context)
                                                  .services[i]
                                                  .enabled,
                                              activeColor: Colors.blue,
                                              onChanged: (val) {
                                                BlocProvider.of<
                                                            EditServiceCubit>(
                                                        context)
                                                    .ChangeService(
                                                        id: BlocProvider.of<
                                                                    ShowServiceCubit>(
                                                                context)
                                                            .services[i]
                                                            .id,
                                                        service_name: BlocProvider
                                                                .of<ShowServiceCubit>(
                                                                    context)
                                                            .services[i]
                                                            .serviceName,
                                                        enabled: val!,
                                                        context: context);
                                                BlocProvider.of<
                                                            ShowServiceCubit>(
                                                        context)
                                                    .getAllServices();
                                              },
                                            ),
                                            Expanded(
                                              child: Text(
                                                BlocProvider.of<
                                                            ShowServiceCubit>(
                                                        context)
                                                    .services[i]
                                                    .serviceName,
                                                style: TextStyle(
                                                 //   color: Colors.black,
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
                            } else if (state is MyFlightEmpty) {
                              return Center(
                                child: Container(
                                  child: Text('There is no  Services'),
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
                                "Flights:",
                                style: TextStyle(
                                   // color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AddFlightCubit>(context)
                                        .getFilters();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddFlight();
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
                        BlocBuilder<ShowFlightCubit, ShowFlightState>(
                          builder: (context, state) {
                            if (state is ShowFlightLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ShowFlightSuccess) {
                              return Expanded(
                                  child: FlightCard(data: state.flights));
                            } else if (state is ShowFlightEmpty) {
                              return Center(
                                child: Container(
                                  child: Text('There is no Flights'),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<ShowFlightCubit>(context)
                                  .deleteAllFlights();
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
                                "Reviews:",
                                style: TextStyle(
                                   // color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<MyFlightCubit, MyFlightState>(
                          builder: (context, state) {
                            if (state is MyFlightSuccess) {
                              return Expanded(
                                  child: FlightReviewsTable(
                                      data: state.flightReview));
                            } else if (state is MyFlightEmpty) {
                              return Center(
                                child: Container(
                                  child: Text('There is no Reviews'),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        Container()
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
