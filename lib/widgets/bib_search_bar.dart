import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';

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
        padding: MaterialStateProperty.all(AppSpacing.horizontalPadding),
        leading: const Icon(
          Icons.search,
          color: AppColors.primaryDark,
        ),
        hintText: "Search participants by BIB...",
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryDark,
              ),
        ),
        hintStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
    );
  }
}
