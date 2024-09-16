import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reserva/presentations/widgets/indicator.dart';
import 'package:reserva/widgets/shared/company_owner_card.dart';
import 'package:reserva/widgets/shared/data_chart.dart';
import 'package:reserva/widgets/shared/pie_chart.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
            "Company Dashboard :",
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
                  child: Text("")// Card(child: CompanyOwnerCard()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " Your Satistics:",
                  style: TextStyle(
                      color: const Color(0xFF064061),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Container(height: 300, width: 600, child:Text('')
                  // ChartsDemo()
                   ),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                           // PieChartSample2(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Indicator(
                                    color: Color(0xff001A45),
                                    text: 'First',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xff024275),
                                    text: 'Second',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xff0185B7),
                                    text: 'Third',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xffA6D7F1),
                                    text: 'Fourth',
                                    isSquare: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
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
  }
}
