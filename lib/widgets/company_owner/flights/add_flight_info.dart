import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_info/cubit/add_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_info/cubit/add_flight_info_state.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_info/cubit/show_flight_info_cubit.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/widgets/shared/drop_down_list.dart';

class AddFlightInfo extends StatelessWidget {
  AddFlightInfo({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerCompanyName = TextEditingController();

  String _companyName = '';

  String? selectedCity;

  List<City>? cities = [
    // CityModel(id: 1, name: 'New York'),
    // CityModel(id: 2, name: 'Los Angeles'),
    // CityModel(id: 3, name: 'Chicago'),
    // CityModel(id: 4, name: 'Houston'),
    // CityModel(id: 5, name: 'Phoenix'),
    // CityModel(id: 6, name: 'Philadelphia'),
    // CityModel(id: 7, name: 'San Antonio'),
    // CityModel(id: 8, name: 'San Diego'),
    // CityModel(id: 9, name: 'Dallas'),
    // CityModel(id: 10, name: 'San Jose')
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlightInfoCubit, AddFlightInfoState>(
        listener: (context, state) {
      if (state is AddFlightInfoFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is AddFlightInfoSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 200,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            content: Text(state.message.toString()),
          ),
        );

        _formKey.currentState?.reset();
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is AddFlightInfoLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return state is AddFlightInfoGotFiltersSuccess
          ? Container(
              width: 100,
              child: AlertDialog(
                title: Text(
                  'Add your information:',
                  style: TextStyle(
                      fontFamily: "DancingScript",
                      color: Color(0xFF064061),
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                content: Container(
                  height: 200,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerCompanyName,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Company Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a company name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _companyName = value!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          child: DropDown(
                            onChanged: (value) {
                              selectedCity = value;
                            },
                            // onTap: () {
                            //   BlocProvider.of<AddMedicineCubit>(context)
                            //       .getFilters();
                            // },
                            // textEditingController: category,
                            title: 'City',
                            hint: 'Select a city',
                            isdropSelected: true,
                            dataList:
                                BlocProvider.of<AddFlightInfoCubit>(context)
                                    .cities,
                            selectedValue: selectedCity,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Color(0xFF064061)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<AddFlightInfoCubit>(context)
                                .AddFlightInfo(
                              airway_name: _controllerCompanyName.text,
                              city_id: selectedCity!,
                            );
                            BlocProvider.of<ShowFlightInfoCubit>(context)
                                .showFlightInfo();
                          }
                          // if (_formKey.currentState!.validate()) {
                          //   _formKey.currentState!.save();

                          //   Navigator.pop(context);
                          /*  Navigator.pushNamed(
                    context,
                    'Category',
                  );*/
                          // }
                        },
                        child: Text('Create',
                            style: TextStyle(color: Color(0xFF064061))),
                      ),
                    ],
                  ),
                  // BlocListener<CategoryCubit, CategoryState>(
                  // listener: (context, state) {},
                  //child:
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
