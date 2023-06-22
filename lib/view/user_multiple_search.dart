import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/dropdown_search/dropdown_search.dart';
import 'package:flutter_dropdown_search/dropdown_search/properties/text_field_props.dart';
import 'package:flutter_dropdown_search/models/user_model.dart';
import 'package:flutter_dropdown_search/view/data_tile.dart';

import '../dropdown_search/properties/popup_props.dart';

class UserMultipleSearch extends StatefulWidget {
  const UserMultipleSearch({Key? key}) : super(key: key);

  @override
  State<UserMultipleSearch> createState() => _UserMultipleSearchState();
}

class _UserMultipleSearchState extends State<UserMultipleSearch> {
  String queryText = '';

  setSearchQuery(String value) {
    queryText = value;
  }

  List<int> selectedItems = [];

  setSelectedItems(List<int> items) {
    selectedItems = items;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch(
          title: "User Multiple Search",
          isMultiSelect: true,
          onBeforePopupOpening: (item) async {
            setSearchQuery("");
            return true;
          },
          preselectedItemIndex: selectedItems,
          clearTextAction: () {
            setSearchQuery("");
          },
          popupProps: PopupProps(
            itemBuilder: (context, data, index) {
              final UserModel model = data;

              final String query = queryText.toLowerCase().trim();
              final String name = model.name.toLowerCase().trim();
              final String id = model.id.toLowerCase().trim();

              if (query.isEmpty) {
                return DataTile(
                  name: model.name,
                  id: model.id,
                  color: Colors.white38,
                );
              } else if (query == name ||
                  query == id ||
                  query.contains(name) ||
                  name.contains(query) ||
                  query.contains(id) ||
                  id.contains(query)) {
                return DataTile(
                  name: model.name,
                  id: model.id,
                  color: Colors.white38,
                );
              }

              return null;
            },
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search Here",
              ),
            ),
          ),
          onSearchTextChange: (value) {
            setSearchQuery(value);
          },
          items: usersList,
          selectedItem: null,
          onSelect: (value) {
            setSelectedItems(value);
            setState(() {});
          },
        ),
        const SizedBox(
          height: 30,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: selectedItems.length,
          itemBuilder: (context, index) {
            final userIndex = selectedItems[index];
            final userData = usersList[userIndex];

            return Text(userData.name);
          },
        )
      ],
    );
  }
}
