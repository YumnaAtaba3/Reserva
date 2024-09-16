import 'package:flutter/material.dart';
import 'package:reserva/widgets/company_owner/flights/flights_reservations.dart';
import 'package:reserva/widgets/company_owner/hotels/hotel_reservations.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text(
            'Reservations',
            style: TextStyle(
                color: const Color(0xFF064061),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),*/
        body: ListView(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notifications :',
            style: TextStyle(
                color: const Color(0xFF064061),
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "DancingScript"),
          ),
          SizedBox(
            width: 850,
          ),
          /*FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          )*/
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisExtent: 150),
              itemCount: 16,
              itemBuilder: ((context, i) {
                return Container(
                  color: Colors.white,
                  height: 200,
                  margin: const EdgeInsets.only(top: 40),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.white,
                    elevation: 10.0,
                    child: ListTile(
                      selected: true,
                      leading: const Icon(
                        Icons.notifications_active_rounded,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'title',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Subtitle',
                          style: const TextStyle(fontSize: 15)),
                      trailing: Text('Trailing'),
                      //leading: const Icon(Icons.account_circle),
                      onTap: () {},
                    ),
                  ),
                );
              }))
        ],
      )
    ]));
  }
}
