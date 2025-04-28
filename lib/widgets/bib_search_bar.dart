import 'package:flutter/material.dart';

class BIBSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const BIBSearchBar({super.key, required this.onChanged});

  @override
  _BIBSearchBarState createState() => _BIBSearchBarState();
}

class _BIBSearchBarState extends State<BIBSearchBar> {
  String query = '';

  void _onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
    widget.onChanged(newQuery);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SearchBar(
        onChanged: _onQueryChanged,
        onSubmitted: _onQueryChanged,
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        leading: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.secondary,
        ),
        hintText: "Search participants by BIB...",
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
    );
  }
}
