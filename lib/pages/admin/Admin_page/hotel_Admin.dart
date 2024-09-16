// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/hotel/hotel_admin_cubit.dart';

class Hotel_Admin extends StatelessWidget {

    final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final textFieldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final hotelAdminCubit = BlocProvider.of<HotelAdminCubit>(context);
  hotelAdminCubit.getHoteltAdmins();
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            width: 700,
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String name = '';
                  String email = '';
                  String hotel_Name = '';
                    String password = '';
                  String con_password = '';

                  return AlertDialog(
                    title: Text('Create Admin', style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 35),
            textAlign: TextAlign.center,
          ),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 400,),
                              TextFormField(
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Hotel name',
                            ),
                                validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Hotel name';
    }
    if (value.length <4) {
      return 'Hotel name must have fewer than 4 characters';
    }

                              return null;
                            },
                            onSaved: (value) {
                              hotel_Name = value!;
                            },
                          ),
                          TextFormField(
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              name = value!;
                            },
                          ),
                          TextFormField(
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email= value!;
                            },
                          ),
                          TextFormField(
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'password',
                            ),
                                validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the password';
    }
    if (value.length < 8) {
      return 'password must have fewer than 8 characters';
    }

                              return null;
                            },
                            onSaved: (value) {
                              password= value!;
                            },
                          ),
                            TextFormField(
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'confirm password',
                            ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the password';
    }
    if (value.length < 8) {
      return 'password must have fewer than 8 characters';
    }

                              return null;
                            },
                            onSaved: (value) {
                              con_password= value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                          hotelAdminCubit.addHotelAdmin(name, email, hotel_Name,password,con_password);
                      Navigator.pop(context);
                      /*  Navigator.pushNamed(
                      context,
                      'Category',
                    );*/
                    }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Use the desired color
                        ),
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Set the text color
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10), // Set the button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Set the button border radius
              ),
            ),
            icon: Icon(Icons.add), // Set the icon
            label: Text(
              'Create Admin',
              style: TextStyle(fontSize: 16), // Set the text style
            ),
          )
        ]),
        SizedBox(
          height: 50,
        ),
          BlocConsumer<HotelAdminCubit, HotelAdminState>(
  listener: (context, state) {
    if (state is HotelAdminErrorState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(state.errorMessage.toString()),
        ),
      );
    } else if (state is HotelAdminLoadedState) {
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
    }
  },
  builder: (context, state) {
    if (state is HotelAdminLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is HotelAdminLoadedState) {
      final hoteltAdminList = state.hotelAdmin;
      return DataTable(
        columnSpacing: 1.0,
        horizontalMargin: 10.0,
        decoration: BoxDecoration(
         // color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        columns: [
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'User Name',
          ),
          DataColumn(
            label: Text(
              'Company name',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'company name',
          ),
          DataColumn(
            label: Text(
              'Email',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
            tooltip: 'Email Address',
          ),
          DataColumn(
            label: Text(
              'Actions',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            numeric: false,
          ),
        ],
        rows: hoteltAdminList.map((dataObject) {
          return DataRow(
            cells: [
              DataCell(Text(dataObject.name ?? '')),
              DataCell(Text(dataObject.companyName ?? '')),
              DataCell(Text(dataObject.email ?? '')),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Admin',
                                style: TextStyle(
                                  fontFamily: "DancingScript",
                                  color: Color(0xFF064061),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Text('Are you sure you want to delete this admin?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    hotelAdminCubit.deleteHotelAdmin(dataObject.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: const Color(0xFF064061),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      );
    } else if (state is HotelAdminErrorState) {
        return Center(
        child: Text('${state.errorMessage}'),
      );
    } else if (state is HotelAdminEmpty) {
      return Center(
        child: Text('${state.message}'),
      );
    }
    return Container();
  },
)]));
  }}
//               BlocBuilder<HotelAdminCubit, HotelAdminState>(
//           builder: (context, state) {
//             if (state is HotelAdminInitial) {
//               return Center(
//                 child: Text('Press the refresh button to load admin.'),
//               );
//             } else if (state is HotelAdminLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is HotelAdminLoadedState) {
//               final hotelAdmin = state.hotelAdmin;

//               if (hotelAdmin.isEmpty) {
//                 return Center(
//                   child: Text('No admin found.'),
//                 );
//               }

//               return DataTable(
//                 columnSpacing: 1.0,
//                 horizontalMargin: 10.0,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 columns: [
//                   DataColumn(
//                     label: Text(
//                       'Name',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                     tooltip: 'User Name',
//                   ),
//                     DataColumn(
//                     label: Text(
//                       'Company name',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                     tooltip: 'company name',
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'Email',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                     tooltip: 'Email Address',
//                   ),
                
                  
//                   DataColumn(
//                     label: Text(
//                       '                                       Actions',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                   ),
//                 ],
//                 rows: (state.hotelAdmin).map((dataObject) {
//                   return DataRow(cells: [
//                     DataCell(Text(dataObject.name??'')),
//                     DataCell(Text(dataObject.companyName??'')),
//                     DataCell(Text(dataObject.email??'')),
                    
              
//                     DataCell(
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             onPressed: () {
                          

//                               showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Delete Admin',
//             style: TextStyle(
//                 fontFamily: "DancingScript",
//                 color: Color(0xFF064061),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25),
//             textAlign: TextAlign.center,
//           ),
//           content: Text('Are you sure you want to delete this admin?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 hotelAdminCubit.deleteHotelAdmin(dataObject.id);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete',style: TextStyle(color: Colors.red),),
//                             ),
//           ],
//         );
//       },
//     );
  
//                             },
//                             icon: Icon(
//                               Icons.delete,
//                               color: const Color(0xFF064061),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]);
//                 }).toList(),
//               );
//             } else if (state is HotelAdminErrorState) {
//               return Center(
//                 child: Text(' ${state.errorMessage}'),
//               );
//             }
//             else if (state is HotelAdminEmpty){ 
//                 return Center(
//                 child: Text(' ${state.message}'),
//               );
//             }
//             return Container();
//           },)]));
//   }
// }


