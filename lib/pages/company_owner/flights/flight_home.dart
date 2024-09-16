import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/shared/home_page/home_page_cubit.dart';
import 'package:reserva/cubits/shared/home_page/home_page_state.dart';
import 'package:reserva/presentations/widgets/indicator.dart';
import 'package:reserva/widgets/shared/chart_widget.dart';
import 'package:reserva/widgets/shared/company_owner_card.dart';
import 'package:reserva/widgets/shared/data_chart.dart';
import 'package:reserva/widgets/shared/pie_chart.dart';

class FlightHome extends StatelessWidget {
  const FlightHome({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomePageCubit>(context).fetchFlightHomePageData();
    // return BlocBuilder<HomePageCubit, HomePageState>(
    //   builder: (context, state) {
    //     if (state is HomePageLoading) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (state is HomePageSuccess) {
    //       return Scaffold(
    //         body: ListView(
    //           children: [
    //             Text(
    //               "Company Dashboard :",
    //               style: TextStyle(
    //                   color: const Color(0xFF064061),
    //                   fontSize: 30,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Container(
    //                     height: 160,
    //                     child: Card(
    //                         child: CompanyOwnerCard(
    //                       data: state.admin,
    //                     )),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     " Your Satistics:",
    //                     style: TextStyle(
    //                         color: const Color(0xFF064061),
    //                         fontSize: 25,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(
    //                         height: 300,
    //                         width: 600,
    //                         child: ChartWidget(
    //                           barChartData: state.barChart,
    //                         )),
    //                     SizedBox(
    //                       width: 100,
    //                     ),
    //                     Container(
    //                       height: 300,
    //                       width: 400,
    //                       child: Card(
    //                           elevation: 5,
    //                           child: Row(
    //                             children: [
    //                               PieChartSample2(
    //                                 pieChartData: state.pieChart,
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Column(
    //                                   mainAxisAlignment: MainAxisAlignment.end,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: <Widget>[
    //                                     Indicator(
    //                                       color: Color(0xff001A45),
    //                                       text: 'First',
    //                                       isSquare: true,
    //                                     ),
    //                                     SizedBox(
    //                                       height: 4,
    //                                     ),
    //                                     Indicator(
    //                                       color: Color(0xff024275),
    //                                       text: 'Second',
    //                                       isSquare: true,
    //                                     ),
    //                                     SizedBox(
    //                                       height: 4,
    //                                     ),
    //                                     Indicator(
    //                                       color: Color(0xff0185B7),
    //                                       text: 'Third',
    //                                       isSquare: true,
    //                                     ),
    //                                     SizedBox(
    //                                       height: 4,
    //                                     ),
    //                                     Indicator(
    //                                       color: Color(0xffA6D7F1),
    //                                       text: 'Fourth',
    //                                       isSquare: true,
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           )),
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     } else if (state is HomePageEmpty) {
    //       return Center(
    //         child: Text("There is no reservations yet"),
    //       );
    //     } else if (state is HomePageFailure) {
    //       return Center(
    //         child: Text("Something went wrong please try again"),
    //       );
    //     } else {
    //       return Text("Something is wrong");
    //     }
    //   },
    // );
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        if (state is HomePageLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePageSuccess) {
          return Scaffold(
            body: ListView(
              children: [
                Text(
                  "Company Dashboard:",
                  style: TextStyle(
                      color: const Color(0xFF064061),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 160,
                        child: Card(child: CompanyOwnerCard(data: state.admin)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " Your Statistics:",
                        style: TextStyle(
                            color: const Color(0xFF064061),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: 300,
                            width: 600,
                            child:ChartWidget(barChartData: state.barChart)),
                        SizedBox(
                          width: 90,
                        ),
                        Expanded(
                          child: Container(
                            height: 300,
                            width: 410,
                            child: Card(
                                elevation: 5,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "     Percentage of reservations during the past four years",
                                        ),
                                        PieChartSample2(
                                          pieChartData: state.pieChart,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Indicator(
                                          color: Color(0xff001A45),
                                          text: '2024',
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: Color(0xff024275),
                                          text: '2023',
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: Color(0xff0185B7),
                                          text: '2022',
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: Color(0xffA6D7F1),
                                          text: '2021',
                                          isSquare: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is HomePageEmpty) {
          return Scaffold(
            body: ListView(
              children: [
                Text(
                  "Company Dashboard:",
                  style: TextStyle(
                      color: const Color(0xFF064061),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 160,
                        child: Card(child: CompanyOwnerCard(data: state.admin)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " Your Statistics:",
                        style: TextStyle(
                            color: const Color(0xFF064061),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is HomePageFailure) {
          return Center(
            child: Text("Something went wrong please try again"),
          );
        } else {
          return Text("Something is wrong");
        }
      },
    );
  }
}
