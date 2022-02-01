import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';

class AddNewHourDialog extends StatefulWidget {
  Function addNewHour;
  late HourManager hourManager;
  late List<String> possiblePartnerCardsNames;

  AddNewHourDialog(this.addNewHour, BuildContext context,
      Animation<double> animation, Animation<double> secondaryAnimation) {
    hourManager = HourManager();
    possiblePartnerCardsNames = hourManager.getListCurrentPartners();
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
  List<String> currentPartnerCardsNames = [''];
  TextEditingController textFieldController = TextEditingController();

  _AddNewHourDialogState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Tennis course'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                bool isCorrect = true;
                currentPartnerCardsNames.map((e) {
                  for (int i = currentPartnerCardsNames.indexOf(e) + 1;
                      i < currentPartnerCardsNames.length;
                      i++) {
                    if (e == currentPartnerCardsNames[i]) {
                      var snackBar = const SnackBar(
                        content: Text("Two same name partners!"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      isCorrect = false;
                    }
                  }
                }).toList();
                if (isCorrect) {
                  currentPartnerCardsNames
                      .toSet()
                      .toList(); //remove more empty string;
                  currentPartnerCardsNames.remove('');
                  widget.addNewHour(
                    TennisHour(
                        date: dateTime,
                        hours: double.parse(numberHour.replaceAll(',', '.')),
                        partner: currentPartnerCardsNames),
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
          padding: const EdgeInsets.all(20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Partner: ',
                        style: labelStyle,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: currentPartnerCardsNames
                          .asMap()
                          .map((i, partnerCard) => (MapEntry(
                                i,
                                PartnerDropDownButton(
                                    partnerCard,
                                    currentPartnerCardsNames,
                                    widget.possiblePartnerCardsNames,
                                    textFieldController,
                                    i,
                                    changeName),
                              )))
                          .values
                          .toList(),
                    )),
                  ],
                ),
              ),
              InkWell(
                  child: Text("ADD PARTNER"),
                  onTap: () {
                    if (currentPartnerCardsNames.last.isNotEmpty) {
                      currentPartnerCardsNames.add('');
                      setState(() {});
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  changeName(String newName, index) {
    setState(() {
      currentPartnerCardsNames[index] = newName;
    });
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
            child: const Text(','),
          ))
        ],
        hideHeader: true,
        title: const Text("Please Select Hours"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
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

class PartnerDropDownButton extends StatefulWidget {
  final String partnerCard;
  final List<String> currentPartnerCardsNames;
  final List<String> possiblePartnerCardsNames;
  final TextEditingController textFieldController;
  final int index;
  final Function changeName;

  const PartnerDropDownButton(
      this.partnerCard,
      this.currentPartnerCardsNames,
      this.possiblePartnerCardsNames,
      this.textFieldController,
      this.index,
      this.changeName,
      {Key? key})
      : super(key: key);

  @override
  State<PartnerDropDownButton> createState() => _PartnerDropDownButtonState();
}

class _PartnerDropDownButtonState extends State<PartnerDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.partnerCard,
      items: widget.possiblePartnerCardsNames.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          if (newValue! == '..add new name') {
            _showNewNameDialog(widget.textFieldController);
          } else {
            widget.changeName(newValue, widget.index);
          }
        });
      },
    );
  }

  Future<void> _showNewNameDialog(
      TextEditingController textFieldController) async {
    String setValue = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New partner name'),
            content: TextField(
              autofocus: true,
              onChanged: (value) {
                setValue = value;
              },
              controller: textFieldController,
              decoration: const InputDecoration(hintText: "New name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (widget.possiblePartnerCardsNames.contains(setValue)) {
                    var snackBar = SnackBar(
                      content: Text("The name $setValue exists!"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    setState(() {
                      widget.possiblePartnerCardsNames.insert(
                          widget.possiblePartnerCardsNames.length - 1,
                          setValue);
                      widget.currentPartnerCardsNames[widget.index] = setValue;
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('OK'),
              )
            ],
          );
        });
  }
}
