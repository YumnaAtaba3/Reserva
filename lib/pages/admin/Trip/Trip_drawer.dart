import 'package:flutter/material.dart';
import 'package:reserva/pages/admin/Admin_page/admin_page.dart';
import 'package:reserva/pages/admin/Attraction/Attraction.dart';
import 'package:reserva/pages/admin/Trip/Trips.dart';
import 'package:reserva/pages/admin/dashboard_page.dart';
import 'package:reserva/pages/admin/reservation.dart';
import 'package:reserva/pages/admin/user_page.dart';
import 'package:reserva/pages/admin/wallet.dart';
import 'package:reserva/pages/shared/settings_page.dart';
import 'package:reserva/utils/app_styles.dart';
import 'package:reserva/pages/admin/Trip/Trip_details.dart';
import 'package:reserva/widgets/shared/logout_dialog.dart';

class Trip_Drawer extends StatefulWidget {
  final trip;

  const  Trip_Drawer({Key? key, this.trip}) : super(key: key);

  @override
  State< Trip_Drawer> createState() => _Trip_DrawerState();
}

class _Trip_DrawerState extends State<Trip_Drawer> {
    List<Widget> _pages = [];
  int _selectedIndex = 0;
      @override
  void initState() {
    super.initState();
    _pages = [
      tripDetails(trip:widget.trip),
      DashboardPage(),
      AdminPage(),
      UserPage(),
      AttractionPage(),
      TripsPage(),
      reservePage(),
      wallet_page(),
      
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        
        title:  Image.asset(
            "images/photo_2024-06-06_20-42-44.jpg",
            height: 100,
            width: 100,
            // height: 200,
            //width: 200,
          ),),
          
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
                  height: 30,
                ),

                ListTile(
                  leading: Icon(Icons.add_location_alt_outlined,
                      color: _selectedIndex == 0
                          ? Colors.blue
                          : Color(0xff085373)),
                  title:
                      Text('Trip Details', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dashboard,
                      color: _selectedIndex == 1
                          ? Colors.blue
                          : Color(0xff085373)),
                  title:
                      Text('Dashboard', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.admin_panel_settings,
                      color: _selectedIndex == 2
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Admin', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person,
                      color: _selectedIndex == 3
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('User', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(3);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.castle_rounded,
                      color: _selectedIndex == 4
                          ? Colors.blue
                          : Color(0xff085373)),
                  title:
                      Text('Attracions', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(4);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.travel_explore_outlined,
                      color: _selectedIndex == 5
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Trips', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(5);
                  },
                ),

                  ListTile(
                  leading: Icon(Icons.receipt_long_sharp,
                      color: _selectedIndex == 6
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Reservations', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(6);
                  },
                ),
          ListTile(
                  leading: Icon(Icons.payment,
                      color: _selectedIndex == 7
                          ? Colors.blue
                          : Color(0xff085373)),
                  title: Text('Wallet', style: AppStyles.styleBold16(context)),
                  onTap: () {
                    _onItemTapped(7);
                  },
                ),
                  
                SizedBox(height: 200),
               
                ListTile(
                  leading: Icon(Icons.logout,
                      color:
                          _selectedIndex == 0 ? Colors.red : Color(0xff085373)),
                  title: Text('Logout', style: AppStyles.styleBold16(context)),
                  onTap: () async {
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
                  icon: Icon(Icons.add_location_alt_outlined),
                  label: 'Tirp Details',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.admin_panel_settings),
                  label: 'Admin',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'User',
                ),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_sharp),
                  label: 'Reservations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'wallet',
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