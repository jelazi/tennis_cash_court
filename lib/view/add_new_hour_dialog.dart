import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';

class AddNewHourDialog extends StatefulWidget {
  Function addNewHour;
  late HourManager hourManager;
  late List<String> partnersValues;

  AddNewHourDialog(this.addNewHour, BuildContext context,
      Animation<double> animation, Animation<double> secondaryAnimation) {
    hourManager = HourManager();
    partnersValues = hourManager.getListCurrentPartners();
  }

  @override
  State<AddNewHourDialog> createState() => _AddNewHourDialogState();
}

class _AddNewHourDialogState extends State<AddNewHourDialog> {
  String numberHour = '2,0';
  DateTime dateTime = DateTime.now();
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
  List<String> partnerCards = [''];

  _AddNewHourDialogState();
  TextEditingController textFieldController = TextEditingController();

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
                bool isCorrect = true;
                partnerCards.map((e) {
                  for (int i = partnerCards.indexOf(e) + 1;
                      i < partnerCards.length;
                      i++) {
                    if (e == partnerCards[i]) {
                      var snackBar = SnackBar(
                        content: Text("Two same name partners!"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      isCorrect = false;
                    }
                  }
                }).toList();
                if (isCorrect) {
                  partnerCards.toSet().toList(); //remove more empty string;
                  partnerCards.remove('');
                  widget.addNewHour(
                    TennisHour(
                        dateTime,
                        double.parse(numberHour.replaceAll(',', '.')),
                        partnerCards),
                  );
                  Navigator.pop(context);
                }
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
              CalendarText(labelStyle, editTextStyle),
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
                        child: Column(
                      children: partnerCards
                          .map(
                            (partnerCard) => DropdownButton(
                              value: partnerCard,
                              items: widget.partnersValues.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue! == '..add new name') {
                                  _showNewNameDialog(textFieldController);
                                } else {
                                  partnerCards.last = newValue;
                                }
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    )),
                  ],
                ),
              ),
              InkWell(
                  child: Text("ADD PARTNER"),
                  onTap: () {
                    //selectedUser.add(null);
                    //linkdevices ++;
                    if (!partnerCards.last.isEmpty) {
                      partnerCards.add('');
                      setState(() {});
                    }
                  })
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

  Future<void> _showNewNameDialog(
      TextEditingController textFieldController) async {
    String setValue = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New partner name'),
            content: TextField(
              onChanged: (value) {
                setValue = value;
              },
              controller: textFieldController,
              decoration: InputDecoration(hintText: "New name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (widget.partnersValues.contains(setValue)) {
                    var snackBar = SnackBar(
                      content: Text("The name $setValue exists!"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    widget.partnersValues
                        .insert(widget.partnersValues.length - 1, setValue);
                    partnerCards.last = setValue;
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }
}

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
          Text('Date: ', style: widget.labelStyle),
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
