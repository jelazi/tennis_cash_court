import 'package:flutter/material.dart';
import '../../model/hour_manager.dart';
import '../cards/listview_cards_hours.dart';
import '../../model/tennis_hour.dart';
import '../cards/sum_card.dart';

class FilterScreen extends StatefulWidget {
  List<TennisHour> _allUsers = [];
  late HourManager hourManager;

  FilterScreen() {
    hourManager = HourManager();
    _allUsers = hourManager.listTennisHours;
  }

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool editable = false;

  List<TennisHour> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    widget._allUsers = widget.hourManager.listTennisHours;
    _foundUsers = widget._allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<TennisHour> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget._allUsers;
    } else {
      results = widget._allUsers
          .where((user) => user
              .getAllChars()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
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
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Positioned(
              top: 60,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                child: ListViewCardsHours(
                    _foundUsers, deleteHour, editHour, editable),
              ),
            ),
            Positioned(
              bottom: 5,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: SumCard(setState, editable)),
            ),
          ],
        ),
      ),
    );
  }

  void deleteHour(TennisHour hour) {
    setState(() {
      widget.hourManager.deleteHour(hour);
    });
  }

  void editHour(TennisHour hour) {
    setState(() {
      print('edit Hour');
    });
  }
}
