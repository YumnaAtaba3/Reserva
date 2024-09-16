import 'package:flutter/material.dart';
import 'package:reserva/pages/admin/Admin_page/flight_admin.dart';
import 'package:reserva/pages/admin/Admin_page/hotel_Admin.dart';



class Admin_tapbar extends StatefulWidget {
  @override
  Admin_tapbarState createState() => Admin_tapbarState();
}

class Admin_tapbarState extends State<Admin_tapbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Admins', style: TextStyle(
                fontFamily: "DancingScript",
                color: Color(0xFF064061),
                fontWeight: FontWeight.bold,
                fontSize: 35),
            textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 100,
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        _buildTabBar(),
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabBarItem('Flight Admins', 0),
        _buildTabBarItem('Hotel Admins', 1),
      ],
    );
  }

  Widget _buildTabBarItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 180),
        decoration: BoxDecoration(
          color: _currentIndex == index ? Colors.blue[800] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: _currentIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              _currentIndex == index ? Icons.check_circle : Icons.circle,
              color: _currentIndex == index ? Colors.white : Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_currentIndex == 0) {
      return Flight_Admin();
    } else if (_currentIndex == 1) {
      return Hotel_Admin();
    }
    return Container();
  }
}
