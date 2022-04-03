import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarText extends StatefulWidget {
  TextStyle labelStyle;
  TextStyle editTextStyle;
  CalendarText(this.labelStyle, this.editTextStyle);

  @override
  State<CalendarText> createState() => _CalendarTextState();
}

class _CalendarTextState extends State<CalendarText> {
  final format = DateFormat("dd. MM. yyyy");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('date'.tr, style: widget.labelStyle),
          Expanded(
            child: DateTimeField(
              initialValue: DateTime.now(),
              format: format,
              style: widget.editTextStyle,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  const time = TimeOfDay(hour: 0, minute: 0);
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
