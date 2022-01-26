import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';

class AddNewHourDialog extends StatefulWidget {
  Function addNewHour;

  AddNewHourDialog(this.addNewHour, BuildContext context,
      Animation<double> animation, Animation<double> secondaryAnimation);

  @override
  State<AddNewHourDialog> createState() => _AddNewHourDialogState();
}

class _AddNewHourDialogState extends State<AddNewHourDialog> {
  final format = DateFormat("dd. MM. yyyy");
  String numberHour = '2,0';
  DateTime dateTime = DateTime.now();
  String partner = '';
  TextStyle labelStyle = TextStyle(
    color: Colors.blue.shade400,
    fontWeight: FontWeight.bold,
    fontSize: 25,
  );
  TextStyle editTextStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Tennis course'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                widget.addNewHour(
                  TennisHour(dateTime,
                      double.parse(numberHour.replaceAll(',', '.')), partner),
                );
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.save,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date: ', style: labelStyle),
                    Expanded(
                      child: DateTimeField(
                        initialValue: DateTime.now(),
                        format: format,
                        style: editTextStyle,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            const time = const TimeOfDay(hour: 0, minute: 0);
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Hours: ',
                      style: labelStyle,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showPickerNumber(context);
                        },
                        child: Text(
                          numberHour,
                          style: editTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Partner: ',
                      style: labelStyle,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: editTextStyle,
                        initialValue: partner,
                        onChanged: (value) => partner = value,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showPickerNumber(BuildContext context) {
    List<String> list = numberHour.split(',');
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            begin: 1,
            end: 10,
            jump: 1,
            initValue: int.parse(list.first),
          ),
          NumberPickerColumn(
              begin: 0, end: 5, jump: 5, initValue: int.parse(list.last)),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Text(','),
          ))
        ],
        hideHeader: true,
        title: Text("Please Select Hours"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            numberHour = picker
                .getSelectedValues()
                .toString()
                .replaceAll(' ', '')
                .replaceAll('[', '')
                .replaceAll(']', '');
          });
        }).showDialog(context);
  }
}
