// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/user/users_cubit.dart';
import 'package:reserva/cubits/admin/flight/flight_admin_cubit.dart';
import 'package:reserva/pages/admin/dashboard_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {

  @override
Widget build(BuildContext context) {
  final usersCubit = BlocProvider.of<UsersCubit>(context);
    usersCubit.getUsers();
  return Scaffold(
    body: ListView(
      children: [
        Text(
          'Users',
          style: TextStyle(
            fontFamily: "DancingScript",
            color: Color(0xFF064061),
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 30,
        ),
//         BlocBuilder<UsersCubit, UsersState>(
//           builder: (context, state) {
//             if (state is UsersInitial) {
//               return Center(
//                 child: Text('Press the refresh button to load users.'),
//               );
//             } else if (state is UsersLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is UsersLoadedState) {
//               final users = state.users;

//               if (users.isEmpty) {
//                 return Center(
//                   child: Text('No users found.'),
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
//                       'Phone Number',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                     tooltip: 'Phone Number',
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'Gender',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                     tooltip: 'gender',
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'Actions',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     numeric: false,
//                   ),
//                 ],
//                 rows: (state.users).map((dataObject) {
//                   return DataRow(cells: [
//                     DataCell(Text(dataObject.name??'')),
//                     DataCell(Text(dataObject.email??'')),
//                     DataCell(Text(dataObject.phone??'')),
//                     DataCell(Text(dataObject.gender??'')),
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
//             'Delete User',
//             style: TextStyle(
//                 fontFamily: "DancingScript",
//                 color: Color(0xFF064061),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25),
//             textAlign: TextAlign.center,
//           ),
//           content: Text('Are you sure you want to delete this user?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                     usersCubit.deleteUsers(dataObject.id);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete',style: TextStyle(color: Colors.red),),
//                             ),
//           ],
//         );
//       },
//     );
//   },
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
//             } else if (state is UsersErrorState) {
//               return Center(
//                 child: Text(' ${state.errorMessage}'),
//               );
//             }
//       else if (state is UsersEmpty) {
//               return Center(
//                 child: Text(' ${state.message}'),
//               );
//             }
//             return Container();
//           },
//         ),
//       ],
//     ),
//   );
// }}
BlocConsumer<UsersCubit, UsersState>(
  listener: (context, state) {
    if (state is UsersErrorState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(state.errorMessage.toString()),
        ),
      );
    } else if (state is UsersLoadedState) {
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
    if (state is UsersLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is UsersLoadedState) {
      final UsersList = state.users;
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
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    numeric: false,
                    tooltip: 'Phone Number',
                  ),
                  DataColumn(
                    label: Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    numeric: false,
                    tooltip: 'gender',
                  ),
                  DataColumn(
                    label: Text(
                      '                               Actions',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    numeric: false,
                  ),
                ],
                rows: (state.users).map((dataObject) {
                  return DataRow(cells: [
                    DataCell(Text(dataObject.name??'')),
                    DataCell(Text(dataObject.email??'')),
                    DataCell(Text(dataObject.phone??'')),
                    DataCell(Text(dataObject.gender??'')),
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
            'Delete User',
            style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 25),
            textAlign: TextAlign.center,
          ),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                    usersCubit.deleteUsers(dataObject.id);
                Navigator.of(context).pop();
              },
              child: Text('Delete',style: TextStyle(color: Colors.red),),
                            ),
          ],
        );
      },
    );
  },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              );
    } else if (state is UsersErrorState) {
      
        return Center(
                child: Text(' ${state.errorMessage}'),
              );
    } else if (state is UsersEmpty) {
      return Center(
        child: Text('${state.message}'),
      );
    }
    return Container();
  },
)]));
  }}





