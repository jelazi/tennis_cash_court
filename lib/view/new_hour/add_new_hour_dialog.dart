import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_picker/flutter_picker.dart';
import '../../controllers/hour_controller.dart';
import 'partner_dropdown_button.dart';
import '../../model/tennis_hour.dart';
import 'calendar_text.dart';

// ignore: must_be_immutable
class AddNewHourDialog extends StatefulWidget {
  final Function addNewHour;
  final HourController hourController = Get.find();

  late List<String> possiblePartnerCardsNames;

  AddNewHourDialog(this.addNewHour, BuildContext context,
      Animation<double> animation, Animation<double> secondaryAnimation,
      {Key? key})
      : super(key: key) {
    possiblePartnerCardsNames = hourController.getListCurrentPartners();
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
  TextStyle editTextStyle = const TextStyle(
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
        title: Text('addNewTennisCourse'.tr),
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
                      var snackBar = SnackBar(
                        content: Text('sameNamePartners'.tr),
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
                  TennisHour tennisHour = TennisHour(
                      dateTime,
                      double.parse(
                        numberHour.replaceAll(',', '.'),
                      ));
                  tennisHour.partners += currentPartnerCardsNames;
                  widget.addNewHour(tennisHour);

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
                      'hours:'.tr,
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
                        'partner'.tr,
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
                  child: Text('addPartner'.tr),
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
        title: Text('selectHours'.tr),
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
