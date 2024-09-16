import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_info/cubit/add_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_info/cubit/add_hotel_info_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_info/cubit/show_hotel_info_cubit.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/widgets/shared/drop_down_list.dart';

class AddHotelInfo extends StatelessWidget {
  AddHotelInfo({super.key});

  final _formKey = GlobalKey<FormState>();

  String _companyName = '';
  String _companyStars = '';

  String _location = '';

  String _description = '';
  final TextEditingController _controllerCompanyName = TextEditingController();
  final TextEditingController _controllerCompanyStars = TextEditingController();
  final TextEditingController _controllerLocation = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  String? selectedCity;

  // List<City>? cities = [
  //   CityModel(id: 1, name: 'New York'),
  //   CityModel(id: 2, name: 'Los Angeles'),
  //   CityModel(id: 3, name: 'Chicago'),
  //   CityModel(id: 4, name: 'Houston'),
  //   CityModel(id: 5, name: 'Phoenix'),
  //   CityModel(id: 6, name: 'Philadelphia'),
  //   CityModel(id: 7, name: 'San Antonio'),
  //   CityModel(id: 8, name: 'San Diego'),
  //   CityModel(id: 9, name: 'Dallas'),
  //   CityModel(id: 10, name: 'San Jose')
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddHotelInfoCubit, AddHotelInfoState>(
        listener: (context, state) {
      if (state is AddHotelInfoFailure) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Text(state.message.toString()),
                )));
      }
      if (state is AddHotelInfoSuccess) {
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
      if (state is AddHotelInfoLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return state is AddHotelInfoGotFiltersSuccess
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
                  height: 350,
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
                        TextFormField(
                          controller: _controllerDescription,
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
                          onSaved: (value) {
                            _description = value!;
                          },
                        ),
                        TextFormField(
                          controller: _controllerLocation,
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
                          onSaved: (value) {
                            _location = value!;
                          },
                        ),
                        TextFormField(
                          controller: _controllerCompanyStars,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'Hotel Stars:',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a stars';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _companyStars = value!;
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
                            //   BlocProvider.of<AddHotelInfoCubit>(context)
                            //       .getFilters();
                            // },
                            // textEditingController: category,
                            title: 'City',
                            hint: 'Select a city',
                            isdropSelected: true,
                            dataList:
                                BlocProvider.of<AddHotelInfoCubit>(context)
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
                            BlocProvider.of<AddHotelInfoCubit>(context)
                                .AddHotelInfo(
                                    hotel_name: _controllerCompanyName.text,
                                    location: _controllerLocation.text,
                                    description: _controllerDescription.text,
                                    city_id: selectedCity!,
                                    stars: _controllerCompanyStars.text);
                            BlocProvider.of<ShowHotelInfoCubit>(context)
                                .showHotelInfo();
                          }
                          // if (_formKey.currentState!.validate()) {
                          // _formKey.currentState!.save();

//Navigator.pop(context);
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

    /* return Container(
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
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
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
                TextFormField(
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
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                TextFormField(
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
                  onSaved: (value) {
                    _location = value!;
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
                    //   BlocProvider.of<AddHotelInfoCubit>(context)
                    //       .getFilters();
                    // },
                    // textEditingController: category,
                    title: 'City',
                    hint: 'Select a city',
                    isdropSelected: true,
                    dataList:
                        BlocProvider.of<AddHotelInfoCubit>(context).cities,
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
                    _formKey.currentState!.save();

                    Navigator.pop(context);
                    /*  Navigator.pushNamed(
                    context,
                    'Category',
                  );*/
                  }
                },
                child:
                    Text('Create', style: TextStyle(color: Color(0xFF064061))),
              ),
            ],
          ),
          // BlocListener<CategoryCubit, CategoryState>(
          // listener: (context, state) {},
          //child:
        ],
      ),
    );*/
  }
}
