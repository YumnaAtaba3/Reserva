import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reserva/pages/company_owner/hotel/hotel_home.dart';

import 'package:reserva/pages/company_owner/hotel/my_hotel.dart';

import 'package:reserva/pages/company_owner/hotel/hotel_reservations.dart';
import 'package:reserva/pages/shared/wallet.dart';
import 'package:reserva/pages/company_owner/hotel/hotel_noti.dart';
import 'package:reserva/pages/shared/settings_page.dart';

import 'package:reserva/utils/app_styles.dart';

import 'package:reserva/widgets/shared/logout_dialog.dart';

class HotelDrawer extends StatefulWidget {
  HotelDrawer({super.key});

  @override
  State<HotelDrawer> createState() => _HotelDrawerState();
}

class _HotelDrawerState extends State<HotelDrawer> {
  int _selectedIndex = 0;
  int logout = 1;

  List<Widget> _pages = [
    HotelHome(),
    MyHotel(),
    HotelReservations(),
    Wallet(),
    SettingsPage(),
    HotelNotifications()
  ];
  void _onItemLogout(int index) {
    setState(
      () {
        logout = 0;
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      logout = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        /* leading:Image.asset(
          "images/d.jpg",
          // height: 200,
          //width: 200,
        ),*/
        title: Expanded(
          child: Image.asset(
            "images/logo4.png",
            height: 55,
            width: 100,
            // height: 200,
            //width: 200,
          ),
        ),
        /*Text(
          "Reserva",
          style: TextStyle(
              color: Color(0xff085373),
              fontSize: 35,
              fontFamily: "DancingScript",
              fontWeight: FontWeight.bold),
        ),*/
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_active_sharp,
                  color: Color(0xFF064061),
                ),
                onPressed: () {
                  _onItemTapped(5);
                  /* Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NotificationsPage();
                        },
                      ),
                    );*/
                },
              ),

              /*IconButton(
                onPressed: () {},
                icon: IconButton(
                  icon: Icon(
                    Icons.sunny,
                    color: Color(0xFF064061),
                  ),
                  onPressed: () {},
                ),
              ),*/
            ],
          )
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 100)],
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.home,
                      color: _selectedIndex == 0
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Home', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
                ListTile(
                  leading: Icon(
                      //Icons.travel_explore_outlined,
                      FontAwesomeIcons.hotel,
                      size: 20,
                      color: _selectedIndex == 1
                          ? Colors.blue
                          : Color(0xff085373)),
                  title:
                      Text('My Hotel', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.receipt_long_sharp,
                      color: _selectedIndex == 2
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Reservations',
                      style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.payment,
                      color: _selectedIndex == 3
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Wallet', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(3);
                  },
                ),
                SizedBox(height: 370),
                ListTile(
                  leading: Icon(Icons.settings,
                      color: _selectedIndex == 4
                          ? Colors.blue
                          : Color(0xff085373)),
                  title:
                      Text('Settings', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(4);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout,
                      color: logout == 0 ? Colors.red : Color(0xff085373)),
                  title: Text('Logout', style: AppStyles.styleBold16(context)),
                  onTap: () async {
                    _onItemLogout(logout);
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return LogoutDialog();
                        });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.hotel),
                  label: 'Hotel',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.report),
                  label: 'Reservations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'logout',
                ),
              ],
            )
          : null,
    );
  }
}
