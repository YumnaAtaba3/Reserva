import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/AddTrip/add_trip_cubit.dart';
import 'package:reserva/cubits/admin/Add_Attraction/add_attraction_cubit.dart';
import 'package:reserva/cubits/admin/Attraction/attraction_cubit.dart';
import 'package:reserva/cubits/admin/EditTrip/edit_trip_cubit.dart';
import 'package:reserva/cubits/admin/Trip/trip_cubit.dart';
import 'package:reserva/cubits/admin/atrractiondetails/attraction_details_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lastattraction/lastattraction_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lastclient/lastclient_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lastflight/lastflight_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/lasthotel/lasthotel_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/newUser/new_users_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/newcompanies/newcompanies_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/totalReservations/total_reservations_cubit.dart';
import 'package:reserva/cubits/admin/editAttraction/edit_attraction_cubit.dart';
import 'package:reserva/cubits/admin/flight/flight_admin_cubit.dart';
import 'package:reserva/cubits/admin/hotel/hotel_admin_cubit.dart';
import 'package:reserva/cubits/admin/reservation/reservation_cubit.dart';
import 'package:reserva/cubits/admin/user/users_cubit.dart';
import 'package:reserva/cubits/admin/walllet/wallet_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_cubit.dart';
//mport 'package:reserva/cubits/company_owner/flight/add/add_flight/cubit/add_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_flight_time/cubit/add_flight_time_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_info/cubit/add_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_service/cubit/add_service_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/flight_reservation/cubit/flight_reservations_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/my_flight/cubit/my_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_info/cubit/show_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_service/cubit/show_service_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight/cubit/edit_flight_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight_time/cubit/edit_flight_time_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_info/cubit/edit_flight_info_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_service/cubit/edit_service_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_facility/cubit/add_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_hotel_photos/cubit/add_hotel_photos_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_room/cubit/add_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/hotel_reservation/cubit/hotel_reservations_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_info/cubit/add_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_hotel_photos/cubit/show_hotel_photos_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_info/cubit/show_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_facility/cubit/edit_facility_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_info/cubit/edit_hotel_info_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_room/cubit/edit_room_cubit.dart';
import 'package:reserva/cubits/shared/home_page/home_page_cubit.dart';
import 'package:reserva/cubits/shared/auth/check_code/cubit/check_code_cubit.dart';
import 'package:reserva/cubits/shared/auth/email_verfication/cubit/email_verification_cubit.dart';
import 'package:reserva/cubits/shared/auth/login/cubit/login_cubit.dart';
import 'package:reserva/cubits/shared/auth/logout/cubit/logout_cubit.dart';
import 'package:reserva/cubits/shared/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:reserva/cubits/shared/wallet/card/cubit/card_cubit.dart';
import 'package:reserva/cubits/shared/wallet/cubit/activity_cubit.dart';

import 'package:reserva/cubits/shared/wallet/line/cubit/line_cubit.dart';
import 'package:reserva/main.dart';
import 'package:reserva/pages/admin/admin_drawer.dart';

import 'package:reserva/pages/company_owner/flights/flight_drawer.dart';
import 'package:reserva/pages/company_owner/hotel/hotel_drawer.dart';
import 'package:reserva/pages/shared/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => EmailVerificationCubit(),
        ),
        BlocProvider(
          create: (context) => CheckCodeCubit(),
        ),
        BlocProvider(
          create: (context) => ResetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
        BlocProvider(
          create: (context) => MyHotelCubit(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider(
          create: (context) => UsersCubit(),
        ),
        BlocProvider(
          create: (context) => FlightAdminCubit(),
        ),
        BlocProvider(
          create: (context) => HotelAdminCubit(),
        ),
        BlocProvider(
          create: (context) => MyFlightCubit(),
        ),
        BlocProvider(
          create: (context) => AddHotelInfoCubit(),
        ),
        BlocProvider(
          create: (context) => AddFlightInfoCubit(),
        ),
        BlocProvider(
          create: (context) => AddFlightCubit(),
        ),
        BlocProvider(
          create: (context) => EditFlightCubit(),
        ),
        BlocProvider(
          create: (context) => AddRoomCubit(),
        ),
        BlocProvider(
          create: (context) => EditRoomCubit(),
        ),
        BlocProvider(
          create: (context) => EditHotelInfoCubit(),
        ),
        BlocProvider(
          create: (context) => EditFlightInfoCubit(),
        ),
        BlocProvider(
          create: (context) => EditFacilityCubit(),
        ),
        BlocProvider(
          create: (context) => EditServiceCubit(),
        ),
        BlocProvider(
          create: (context) => ShowFacilityCubit(),
        ),
        BlocProvider(
          create: (context) => AddFacilityCubit(),
        ),
        BlocProvider(
          create: (context) => AddServiceCubit(),
        ),
        BlocProvider(
          create: (context) => ShowServiceCubit(),
        ),
        BlocProvider(
          create: (context) => AddHotelPhotosCubit(),
        ),
        BlocProvider(
          create: (context) => AddFlightTimeCubit(),
        ),
        BlocProvider(
          create: (context) => ShowFlightCubit(),
        ),
        BlocProvider(
          create: (context) => ShowFlightInfoCubit(),
        ),
        BlocProvider(
          create: (context) => ShowRoomCubit(),
        ),
        BlocProvider(
          create: (context) => ShowHotelInfoCubit(),
        ),
        BlocProvider(
          create: (context) => ShowHotelPhotosCubit(),
        ),
        BlocProvider(
          create: (context) => EditFlightTimeCubit(),
        ),
        BlocProvider(
          create: (context) => FlightReservationsCubit(),
        ),
        BlocProvider(
          create: (context) => HotelReservationsCubit(),
        ),
        BlocProvider(
          create: (context) => ActivityCubit(),
        ),
        BlocProvider(
          create: (context) => CardCubit(),
        ),
        BlocProvider(
          create: (context) => LineCubit(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider(
          create: (context) => AttractionCubit(),
        ),
        BlocProvider(
          create: (context) => AttractionDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => EditAttractionCubit(),
        ),
        BlocProvider(
          create: (context) => TripCubit(),
        ),
        BlocProvider(
          create: (context) => EditTripCubit(),
        ),
        BlocProvider(
          create: (context) => AddTripCubit(),
        ),
        BlocProvider(
          create: (context) => UsersCubit(),
        ),
        BlocProvider(
          create: (context) => AddAttractionCubit(),
        ),
        BlocProvider(
          create: (context) => FlightAdminCubit(),
        ),
        BlocProvider(
          create: (context) => HotelAdminCubit(),
        ),
        BlocProvider(
          create: (context) => WalletCubit(),
        ),
        BlocProvider(
          create: (context) => LastclientCubit(),
        ),
        BlocProvider(
          create: (context) => LastattractionCubit(),
        ),
        BlocProvider(
          create: (context) => NewUsersCubit(),
        ),
        BlocProvider(
          create: (context) => TotalReservationsCubit(),
        ),
        BlocProvider(
          create: (context) => NewcompaniesCubit(),
        ),
        BlocProvider(
          create: (context) => LastflightCubit(),
        ),
        BlocProvider(
          create: (context) => LasthotelCubit(),
        ),
                BlocProvider(
          create: (context) => ReservationCubit(),
        ),
      ],
      child: /* MaterialApp(
         // home: DrawerPage(),
        )*/

        BlocProvider<ThemeModeCubit>(
      create: (_) => ThemeModeCubit(),
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              if (snapshot.hasData) {
                final prefs = snapshot.data!;
                final token = prefs.getString('token');
                final role_id = prefs.getInt('role_id');

                if (prefs.getString('token') == null) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Login(),
                  );
                } else if (prefs.getString('token') != null && prefs.getInt('role_id') == 1) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: HotelDrawer(),
                    theme: themeMode == ThemeMode.light
                        ? ThemeData.light().copyWith(primaryColorLight: Colors.brown)
                        : ThemeData.dark(),
                  );
                } else if (prefs.getString('token') != null && prefs.getInt('role_id') == 2) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: FlightDrawer(),
                    theme: themeMode == ThemeMode.light
                        ? ThemeData.light().copyWith(primaryColorLight: Colors.brown)
                        : ThemeData.dark(),
                  );
                } else if (prefs.getString('token') != null && prefs.getInt('role_id') == 3) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: AdminDrawer(),
                    theme: themeMode == ThemeMode.light
                        ? ThemeData.light().copyWith(primaryColorLight: Colors.brown)
                        : ThemeData.dark(),
                  );
                }
              }

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: Text('Error: Unable to load shared preferences'),
                  ),
                ),
              );
            },
          );
        },
      ),
    ));
  }
}

//           FutureBuilder<SharedPreferences>(
//         future: SharedPreferences.getInstance(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             );
//           }

//           if (snapshot.hasData) {
//             final prefs = snapshot.data!;
//             final token = prefs.getString('token');
//             final role_id = prefs.getInt('role_id');

//             if (prefs?.getString('token') == null) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: Login(),
//               );
//             } else if (prefs?.getString('token') != null &&
//                 prefs?.getInt('role_id') == 1) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: HotelDrawer(),
//               );
//             } else if (prefs?.getString('token') != null &&
//                 prefs?.getInt('role_id') == 2) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: FlightDrawer(),
//               );
//             } else if (prefs?.getString('token') != null &&
//                 prefs?.getInt('role_id') == 3) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: AdminDrawer(),
//               );
//             }
//           }

//           return const MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//               body: Center(
//                 child: Text('Error: Unable to load shared preferences'),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
