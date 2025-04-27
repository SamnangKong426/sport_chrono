import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF7B8DCF);
const Color kSelectedColor = Color(0xFF243882);


class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onQueryChanged,
      decoration: InputDecoration(
        labelText: 'Search participants by BIB...',
        prefixIcon: Icon(Icons.search, color: kSelectedColor),
        labelStyle: TextStyle(color: kSelectedColor, fontSize: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: kSelectedColor,
            width: 2, // Increased border width
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: kSelectedColor,
            width: 2, // Increased border width
          ),
        ),
      ),
    );
  }
}
