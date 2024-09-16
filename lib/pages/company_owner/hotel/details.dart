import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reserva/pages/company_owner/drawer.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return DrawerPage();
  }
}
