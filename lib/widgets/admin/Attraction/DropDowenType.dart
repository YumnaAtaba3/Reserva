import 'package:flutter/material.dart';

import '../../../models/admin/attraction_model.dart';




class DropDownAttraction extends StatefulWidget {
  final String title;
  final String hint;
  final bool isdropSelected;
  final List<AttractionType>? dataList; 

  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? selectedValue;

  const  DropDownAttraction(
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
  DropDownAttractionState createState() => DropDownAttractionState();
}

class DropDownAttractionState extends State<DropDownAttraction> {
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
          style: TextStyle(color: const Color(0xFF064061),),
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
            items: widget.dataList?.map((AttractionType value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.attractionTypeName),
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




