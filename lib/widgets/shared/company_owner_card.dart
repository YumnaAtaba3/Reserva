import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';

class CompanyOwnerCard extends StatelessWidget {
  List<Admin> data;
  CompanyOwnerCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.place,
                color: Colors.blue,
              ),
              Text(
                "Company Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Text(
            data[0].companyName,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.blue,
              ),
              Text(
                " Email:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Text(
            data[0].email,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        /*ListTile(
          title: Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.blue,
              ),
              Text(
                "Phone:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Text(
            "09547462390",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),*/
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.admin_panel_settings,
                color: Colors.blue,
              ),
              Text(
                "Admin:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Text(
            data[0].name,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
