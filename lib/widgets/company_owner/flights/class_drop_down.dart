import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/flight_class.dart';
import 'package:reserva/models/room_type.dart';

class ClassDropDown extends StatefulWidget {
  final String title;
  final String hint;
  final bool isdropSelected;
  final List<FlightClass>? dataList;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? selectedValue;
  ClassDropDown(
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
  ClassDropDownState createState() => ClassDropDownState();
}

class ClassDropDownState extends State<ClassDropDown> {
  String? selectedValue;
  List<String>? selectedValues = [];
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
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          items:
              widget.dataList!.map((e) => MultiSelectItem(e, e.name)).toList(),
          onConfirm: (values) {
            setState(() {
              selectedValues = values.map((e) => e.name).toList();
            });
            widget.onChanged?.call(selectedValues!.join(','));
          },
          selectedColor: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        /* Container(
          width: 900,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            items: widget.dataList?.map((FlightClass value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.name),
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
        ),*/
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
