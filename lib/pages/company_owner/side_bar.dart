import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:reserva/widgets/shared/logout_dialog.dart';

class SideBar extends StatefulWidget {
  //static String id = 'SideBar';
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late bool _color;

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Color.fromARGB(255, 8, 65, 111),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.blueGrey[400],
                      size: 100,
                    ),
                  ),
                  Text(
                    "admin@gmail.com",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "DancingScript",
                        color: Colors.white),
                  )
                ],
              ),

              /*Card(
                elevation: 10.0,
                child: Container(
                  color: Colors.blueGrey[200],
                  child: ListTile(
                    selected: true,
                    title: const Text(
                      'Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(Icons.account_circle),
                    onTap: () {
                      setState(() {
                        _color = !_color;
                      });
                      Navigator.pushNamed(
                        context,
                        'Profile',
                      );
                    },
                  ),
                ),
              ),*/
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              color: Colors.blueGrey[200],
              elevation: 10.0,
              child: ListTile(
                title: const Text(
                  'Medicine',
                  style: TextStyle(color: Colors.black),
                ),
                selected: true,
                leading: const Icon(Icons.medical_services_rounded),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'HomePage',
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              color: Colors.blueGrey[200],
              elevation: 10.0,
              child: ListTile(
                selected: true,
                title: const Text(
                  'Categories',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.category_rounded),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'Category',
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              elevation: 10.0,
              color: Colors.blueGrey[200],
              child: ListTile(
                selected: true,
                title: const Text(
                  'Companies',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(FontAwesomeIcons.buildingCircleCheck),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'Company',
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              elevation: 10.0,
              color: Colors.blueGrey[200],
              child: ListTile(
                selected: true,
                title: const Text(
                  'Reports',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.receipt_long_sharp),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              'FirstReport',
                            );
                          },
                          icon: Icon(Icons.arrow_back)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              'SecondReport',
                            );
                          },
                          icon: Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'FirstReport',
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              elevation: 10.0,
              color: Colors.blueGrey[200],
              child: ListTile(
                selected: true,
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.logout),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        //width: 100,
      ),
    );
  }
}
