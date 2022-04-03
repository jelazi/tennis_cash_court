import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/hour_controller.dart';
import '../../model/tennis_hour.dart';
import '../cards/card_hour.dart';
import '../cards/sum_card.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final HourController hourController = Get.find();
  bool editable = false;

  RxList _foundUsers = RxList();
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = hourController.listTennisHours;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    RxList results = RxList();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = hourController.listTennisHours;
    } else {
      results.value = hourController.listTennisHours
          .where((user) => user
              .getAllChars()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers.value = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'search'.tr, suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Positioned(
              top: 60,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                child: ListView(
                  shrinkWrap: true,
                  children: _foundUsers
                      .map((element) => InkWell(
                            child: CardHour(
                              element,
                              editable,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Container()),
            ),
          ],
        ),
      ),
    );
  }
}
