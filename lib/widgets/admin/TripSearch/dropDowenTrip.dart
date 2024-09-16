// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:reserva/models/admin/service.dart';

class TripDropDown extends StatefulWidget {
  final String title;
  final String hint;
  final bool isdropSelected;
  final List<Service>? dataList;
  final void Function(String?)? onChanged;
  final void Function()? onTap;

  final List<String>? selectedValues;
  TripDropDown(
      {required this.title,
      required this.hint,
      required this.isdropSelected,
      this.dataList,
      Key? key,
      required this.onChanged,
      @required this.onTap,
      this.selectedValues})
      : super(key: key);

  @override
  TripDropDownState createState() => TripDropDownState();
}

class TripDropDownState extends State<TripDropDown> {
  List<String>? selectedValues = [];
  void onDropDownChanged(int? value) {
    setState(() {
      selectedValues = value as List<String>?;
      // widget.textEditingController.text = value ?? "";
    });
    showSnackBar(value.toString());
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(
          height: 5.0,
        ),
        MultiSelectDialogField(
          dialogWidth: 200,
          dialogHeight: 300,
          buttonText: Text(
            selectedValues!.isNotEmpty
                ? selectedValues!.join(',')
                : widget.hint,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          title: Text(widget.title),
          items: (widget.dataList ?? []).map((e) => MultiSelectItem(e, e.serviceName)).toList(),
          onConfirm: (values) {
            setState(() {
              selectedValues = values.isNotEmpty
                  ? values.map((e) => e.id.toString()).toList()
                  : [];
            });
            widget.onChanged?.call(selectedValues!.join(','));
          },
          selectedColor: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
