import 'package:flutter/material.dart';

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
