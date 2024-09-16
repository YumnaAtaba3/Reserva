import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_info/cubit/show_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_info/cubit/edit_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_info/cubit/edit_hotel_info_state.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/widgets/shared/drop_down_list.dart';

class EditHotelInfo extends StatelessWidget {
  EditHotelInfo({super.key, required this.data});
  final List<HotelInfo> data;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerCompanyName = TextEditingController();
  final TextEditingController _controllerCompanyStars = TextEditingController();
  final TextEditingController _controllerLocation = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  String? companyName;

  String? location;

  String? description;

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
    return BlocConsumer<EditHotelInfoCubit, EditHotelInfoState>(
        listener: (context, state) {
      if (state is EditHotelInfoFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is EditHotelInfoSuccess) {
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
        BlocProvider.of<ShowHotelInfoCubit>(context).showHotelInfo();
      }
    }, builder: (context, state) {
      if (state is EditHotelInfoLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Container(
        width: 100,
        child: AlertDialog(
          title: Text(
            'Edit your information:',
            style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 35),
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 350,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: data[0].hotelName,
                    //controller: _controllerCompanyName,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      labelText: 'Company Name',
                      // hintText: data[0].hotelName
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      companyName = value;
                    },
                  ),
                  TextFormField(
                    initialValue: data[0].description,
                    // controller: _controllerDescription,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  TextFormField(
                    // controller: _controllerLocation,
                    initialValue: data[0].location,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      labelText: 'Location',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the company location';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      location = value;
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
                      hint: data[0].city.cityName,
                      isdropSelected: true,
                      dataList:
                          BlocProvider.of<EditHotelInfoCubit>(context).cities,
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
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<EditHotelInfoCubit>(context)
                          .EditHotelInfo(
                        hotel_name: companyName == null
                            ? data[0].hotelName
                            : companyName!,
                        city_id: selectedCity == null
                            ? data[0].city.id.toString()
                            : selectedCity!,
                        description: description == null
                            ? data[0].description
                            : description!,
                        location:
                            location == null ? data[0].location : location!,
                      );
                      BlocProvider.of<ShowHotelInfoCubit>(context)
                          .showHotelInfo();
                      /*  Navigator.pushNamed(
                    context,
                    'Category',
                  );*/
                    }
                  },
                  child:
                      Text('Edit', style: TextStyle(color: Color(0xFF064061))),
                ),
              ],
            ),
            // BlocListener<CategoryCubit, CategoryState>(
            // listener: (context, state) {},
            //child:
          ],
        ),
      );
    });
  }
}
