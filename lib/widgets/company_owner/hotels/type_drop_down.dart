import 'package:flutter/material.dart';

import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class RoomTypeDropDown extends StatefulWidget {
  final String title;
  final String hint;
  final bool isdropSelected;
  final List<RoomType>? dataList;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? selectedValue;
  RoomTypeDropDown(
      {required this.title,
      required this.hint,
      required this.isdropSelected,
      this.dataList,
      Key? key,
      required this.onChanged,
      @required this.onTap,
      this.selectedValue})
      : super(key: key);

  @override
  RoomTypeDropDownState createState() => RoomTypeDropDownState();
}

class RoomTypeDropDownState extends State<RoomTypeDropDown> {
  String? selectedValue;
  void onDropDownChanged(String? value) {
    setState(() {
      selectedValue = value;
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
        Container(
          width: 900,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            items: widget.dataList?.map((RoomType value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.roomType),
              );
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              contentPadding:
                  const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
              hintText: widget.hint,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
