import 'package:flutter/material.dart';

class AdminFlight {
   final int id;
  final String name;
  final String email;
  final String companyName;

  AdminFlight({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });

  factory AdminFlight.fromJson(Map<String, dynamic> json) {
    return AdminFlight(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      companyName: json['company_name'],
    );
  }
} 


class AddAdminFlight {
  final String name;
  final String email;
  final String companyName;
  final String password;
   final String confirm_password;

  AddAdminFlight({
    required this.name,
    required this.email,
    required this.companyName,
    required this.password,
    required this.confirm_password,
  });

  factory AddAdminFlight.fromJson(Map<String, dynamic> json) {
    return AddAdminFlight(
      name: json['name'],
      email: json['email'],
      companyName: json['company_name'],
      password: json['password'],
      confirm_password: json['password_confirmation']
    );
  }
}