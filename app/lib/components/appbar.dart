//https://www.kindacode.com/article/flutter-add-a-search-field-to-the-app-bar/

// https://api.flutter.dev/flutter/cupertino/CupertinoSearchTextField-class.html

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

//PreferredSizeWidget
//StatelessWidget

AppBar myAppBar(context, myTitle, searchPage) {
  return AppBar(
    title: Text(myTitle),
    actions: [
      // Navigate to the Search Screen
      IconButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SearchPage())),
          icon: Icon(Icons.search))
    ],
  );
}

// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText:
                    AppLocalizations.of(context)!.searchHint /*'Search...'*/,
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}
